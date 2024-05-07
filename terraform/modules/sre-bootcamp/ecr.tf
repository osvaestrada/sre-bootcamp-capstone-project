resource "aws_ecr_repository" "sre-bootcamp" {
  name = "sre-bootcamp-${var.env}"
}

resource "aws_ecr_lifecycle_policy" "sre-bootcamp-policy" {
  repository = aws_ecr_repository.sre-bootcamp.name
  policy     = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Delete older images",
                "selection": {
                    "tagStatus": "any",
                    "countType": "imageCountMoreThan",
                    "countNumber": 4
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}
