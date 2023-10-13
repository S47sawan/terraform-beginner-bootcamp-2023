terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
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
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#   source              = "./modules/terrahouse_aws"
#   user_uuid           = var.user_uuid
#   bucket_name         = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

resource "terratowns_home" "home" {
  name = "Lets Get Cooking! :pot_of_food:" 
  description = <<DESCRIPTION
  Are you passionate about the art of cooking or simply looking to whip up a quick and delicious meal? 
  You've come to the right place! 
  "Let's Get Cooking" is your virtual kitchen and a haven for food lovers from all walks of life .
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "cooker-cove"
  content_version = 1
}