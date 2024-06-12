terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
}
provider "aws" {
  region = var.region
}
module "eks" {
  source = "./eks"
  # depends_on = [ module.vpc ]
  private_subnet_ids  = module.vpc.private_subnet_ids
  ecr_repo_policy_arn = module.ecr.ecr_repo_policy_arn
  vpc_id              = module.vpc.vpc_id
}
module "vpc" {
  source = "./vpc"
}
module "ecr" {
  source = "./ecr"
}