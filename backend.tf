terraform {
  backend "s3" {
    bucket         = "srmlab-awsfreetier-terraform-state"
    key            = "srmlab-awsfreetier/terraform.state"
    region         = "us-east-1"
    dynamodb_table = "srmlab-awsfreetier-terraform-state-locks"
    encrypt        = true
  }
}