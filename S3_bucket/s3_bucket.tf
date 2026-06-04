module "versioning" {
	source = "./Modules/versioning"
}

terraform {
	required_providers {
		vault = {
			source = "hashicorp/vault"
			version = "2.0.0"
		}
		aws = {
			source = "hashicorp/aws"
			version = "4.67.0"
		}
	}
}

provider "vault" {

}

data "vault_aws_access_credentials" "creds" {
	backend = "aws"
	role = "app-role"
}

provider "aws" {
	region = "us-east-1"
	access_key = data.vault_aws_access_credentials.creds.access_key
	secret_key = data.vault_aws_access_credentials.creds.secret_key
}

resource "aws_s3_bucket" "bucket" {
  bucket = "s3-bucket-2026-terraform-state-file"
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]

  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}