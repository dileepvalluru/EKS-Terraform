output "cluster_id" {
  value = module.eks.cluster_id
}
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "security_group_id" {
  value = module.eks.node_security_group_id
}
output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}
output "eks_role_arn" {
  value = module.eks.cluster_iam_role_name
}

