# Create the ECR repository
resource "aws_ecr_repository" "watchdogit-eks-repo" {
  name                 = "watchdogit-eks-repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Create the ECR repository policy
resource "aws_iam_policy" "watchdogit_repo_policy" {
  name = "watchdogit_repo_policy"
  policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy",
            ],
            Resource = aws_ecr_repository.watchdogit-eks-repo.arn
        }
    ]
  }
   )
}

# # Create the ECR lifecycle policy
# resource "aws_ecr_lifecycle_policy" "my_ecr_repo_lifecycle_policy" {
#   repository = aws_ecr_repository.my_ecr_repo.name

#   policy = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Expire untagged images older than 14 days",
#             "selection": {
#                 "tagStatus": "untagged",
#                 "countType": "sinceImagePushed",
#                 "countUnit": "days",
#                 "countNumber": 14
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# }