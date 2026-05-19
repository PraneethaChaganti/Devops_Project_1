module "versioning" {
	source = "./Modules/versioning"
}

terraform {
	required_providers {
		vault = {
			source = "hashicorp/vault"
		}
		aws = {
			source = "hashicorp/aws"
		}
	}
}

provider "vault" {
	address = "http://127.0.0.1:8200"
	token = "myroot"
}

data "vault_aws_access_credentials" "creds" {
	backend = "aws"
	role = "terraform-admin"
}

provider "aws" {
	region = "us-east-1"
	access_key = data.vault_aws_access_credentials.creds.access_key
	secret_key = data.vault_aws_access_credentials.creds.secret_key
	token = data.vault_aws_access_credentials.creds.security_token
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-bucket"
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