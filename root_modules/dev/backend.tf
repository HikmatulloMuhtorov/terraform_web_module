terraform {
  backend "s3" {
    bucket         = "aws-session-may2022-remote-backend-hik"
    key            = "module/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-may2022-state-lock-table"
  }
}