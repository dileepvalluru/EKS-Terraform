module "vpc" {
  source = "../vpc"
}
module "ecr" {
  source = "../ecr"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.8.4"
  cluster_name    = "watchdogit-cluster"
  cluster_version = "1.30"
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnet_ids
  cluster_endpoint_public_access  = true
  enable_irsa     = true

  iam_role_additional_policies = {
    ecr_read_only = var.ecr_repo_policy_arn
  }

  eks_managed_node_group_defaults = {
    ami_type     = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    node_group = {
      min_size     = 1
      max_size     = 3
      desired_size = 1
      instance_types = ["t3.medium"]
      autoscaling_enabled = true
      autoscaling_profile = "default"
    }
  }
  tags = {
    cluster = "watchdogit-eks"
  }

  depends_on = [module.vpc]
}

module "vpc_cni_irsa_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "watchdogit-vpc-cni-irsa"

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }
  depends_on = [module.eks]
}