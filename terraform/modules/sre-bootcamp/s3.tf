# resource "aws_s3_bucket" "sre-bootcamp-bucket" {
#     bucket = "sre-bootcamp-bucket-${var.env}"
#     force_destroy =true
# }

# resource "aws_s3_bucket_versioning" "versioning" {
#   bucket = aws_s3_bucket.sre-bootcamp-bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
#   bucket = aws_s3_bucket.sre-bootcamp-bucket.bucket

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm     = "AES256"
#     }
#   }
# }