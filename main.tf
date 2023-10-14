terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}
#backend terraform cloud
terraform {
  cloud {
    organization = "cloudgirl"

    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

module "home_pacman_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  content_version = var.content_version
  public_path     = var.pacman_public_path
}

resource "terrahouse_aws" "home_pacman" {
  name            = "Lets Play Pac-Man!"
  description     = <<DESCRIPTION
  "Pac-Man" is a classic arcade game that was first released in 1980 by Namco (formerly known as Midway). 
   It was created by Toru Iwatani and quickly became one of the most iconic and beloved video games in history. 
  The game's objective is simple: guide the character "Pac-Man" through a maze, eating all the dots while avoiding ghosts.
DESCRIPTION
  domain_name     = module.home_pacman_hosting.domain_name
  town            = "missingo"
  content_version = 1
}

# module "home_cinnamon_hosting" {
#   public_path     = var.cinnamon_public_path
#   source          = "./modules/terrahome_aws"
#   user_uuid       = var.teacherseat_user_uuid
#   content_version = var.content_version
# }

# resource "terrahouse_aws" "home_cinnamon" {
#   name            = "Scrumdiddlyumptious Cinnamon Buns!"
#   description     = <<DESCRIPTION
#    As the trees start to shed  their leaves and the days grow colder and shorter why not
#    lift your spirits with some home made delicious cinnamon buns! Try this recipe today!
# DESCRIPTION
#   domain_name     = module.home_cinnamon_hosting.domain_name
#   town            = "missingo"
#   content_version = 1
# }