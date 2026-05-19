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
	bucket = "my-terraform-bucket-123456789"
	acl    = "private"
	tags = {
		Name        = "My Terraform Bucket"
		Environment = "Dev"
	}
}