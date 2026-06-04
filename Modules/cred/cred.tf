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
	address = "http://172.18.0.3:8200" 
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