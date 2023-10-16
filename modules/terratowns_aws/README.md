  ## Terrahome AWS

 ```tf
 module "home_pacman" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  content_version = var.content_version
  public_path     = var.pacman_public_path
}
```
Its important to note that the public directory expects the following:

- index.html
- error.html
- assets
  
All top level file in assets will be copied, but not any subdirectories.