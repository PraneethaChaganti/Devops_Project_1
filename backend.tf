terraform {
  backend "s3" {
    bucket         = "s3-bucket-2026-terraform-state-file"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-table-terraform-state-locking"
    encrypt        = true
  }
}