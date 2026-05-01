terraform {
	resource_provider {
		local {
			source = "/hashicorp/local"
			version = ~>2.0
		}
	}
}

provider "aws" {
	region = "us-east-1"
}

resource "aws_security_group" "example" {
	name        = "example"
	description = "Example security group"
	vpc_id      = "vpc-12345678"

	ingress {
		description      = "Allow SSH"
		from_port        = 22
		to_port          = 22
		protocol         = "tcp"
		cidr_blocks      = [""]

	egress {
		description      = "Allow all outbound traffic"
		from_port        = 0
		to_port          = 0
		protocol         = "-1"
		cidr_blocks      = [""]
	}

resource "aws_instance" "example" {
	ami           = "ami-12345678"
	instance_type = "t2.micro"
	key_name      = "my-key-pair"
	security_groups = [aws_security_group.example.name]
}