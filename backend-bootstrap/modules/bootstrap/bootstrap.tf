##
# Module to build the Azure DevOps "seed" configuration
##

# Build an S3 bucket to store TF state
resource "aws_s3_bucket" "state_bucket" {
  bucket = var.name_of_s3_bucket

  # Prevents Terraform from destroying or replacing this object - a great safety mechanism
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket" {
  bucket = aws_s3_bucket.state_bucket.id

    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  
}

resource "aws_s3_bucket_versioning" "state_bucket" {
    bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Build a DynamoDB to use for terraform state locking
resource "aws_dynamodb_table" "tf_lock_state" {
  name = var.dynamo_db_table_name

  # Pay per request is cheaper for low-i/o applications, like our TF lock state
  billing_mode = "PAY_PER_REQUEST"

  # Hash key is required, and must be an attribute
  hash_key = "LockID"

  # Attribute LockID is required for TF to use this table for lock state
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.dynamo_db_table_name
    BuiltBy = "Terraform"
  }
}
