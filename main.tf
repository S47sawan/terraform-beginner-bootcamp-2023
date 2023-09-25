#Random Provider
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

#Create Resource s3 bucket 
resource "random_string" "bucket_name" {
  length           = 16
  special          = false
}
# Create output
output "random_bucket_name" {
    value = random_string.bucket_name.result
}