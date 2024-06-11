variable "private_subnet_ids" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "ecr_repo_policy_arn" {
  type = string
}