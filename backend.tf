 #Enable dynamoDB backend for Terraform state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "Dev"
  }
}



#Configure the S3 backend for Terraform state storage
terraform {
  backend "s3" {
     bucket        = "test-bucket-terraform-2026-jackie-12345"
     key           = "autoscaling/terraform.tfstate"
     region        = "us-east-1"
     use_lockfile  = true
     encrypt       = true
   }
 }


