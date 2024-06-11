output "ecr_repo_url" {
  value = aws_ecr_repository.watchdogit-eks-repo.repository_url
}
output "ecr_repo_policy_arn" {
  value = aws_iam_policy.watchdogit_repo_policy.arn
}