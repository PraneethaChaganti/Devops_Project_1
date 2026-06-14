terraform {
	required_providers {
		local = {
			source = "hashicorp/local"
			version = "~> 2.0"
		}
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

provider "aws" {
	region = "us-east-1"
} 