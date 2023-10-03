#AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
#Create Resource s3 bucket
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUUID = "var.user_uuid"
  }
}
