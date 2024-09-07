# terraform {
#   backend "s3" {
#     bucket         = "terraform-lab-bucket-sstate"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-lock-state"
#     encrypt        = true
#   }
# }
