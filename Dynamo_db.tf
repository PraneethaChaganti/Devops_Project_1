module "versioning" {
	source = "./Modules/cred"
}

resource aws_dynamodb_table "dynamodb_table" {
  name         = "dynamodb-table-2026-terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
	name = "LockID"
	type = "S"
  }
  tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
	}
}
