# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  #backend "s3" {
  #  bucket         = "your_globally_unique_bucket_name"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  dynamodb_table = "aws-locks"
  #  encrypt        = true
  #}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region = "us-east-1"
}

# Call the seed_module to build our ADO seed info
module "bootstrap" {
  source               = "./modules/bootstrap"
  name_of_s3_bucket    = "srmlab-awsfreetier-terraform-state"
  dynamo_db_table_name = "srmlab-awsfreetier-terraform-state-locks"
}
