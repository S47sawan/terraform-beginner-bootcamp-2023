terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}
#backend terraform cloud
# terraform {
#   cloud {
#     organization = "cloudgirl"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid
  bucket_name         = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name            = "Lets Get Cooking!"
  description     = <<DESCRIPTION
  Are you passionate about the art of cooking or simply looking to whip up a quick and delicious meal? 
  You've come to the right place! 
  "Let's Get Cooking" is your virtual kitchen and a haven for food lovers from all walks of life .
DESCRIPTION
  domain_name     = module.terrahouse_aws.cloudfront_url
  town            = "missingo"
  content_version = 1
}