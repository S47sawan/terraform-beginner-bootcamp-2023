#----------------------------------------------------------------------------------------------------------------------------
# Declare Variables
#----------------------------------------------------------------------------------------------------------------------------
variable "teacherseat_user_uuid" {
  description = "User UUID"
  type        = string
}
variable "pacman_public_path" {
  description = "The file path for the public directory"
  type        = string
}
# variable "cinnamon_public_path" {
#   description = "The file path for the public directory"
#   type        = string
# }
variable "content_version" {
  description = "Version number for content"
  type        = number
}

variable "terratowns_endpoint" {
  description = "point of access to terratowns"
  type        = string
}
variable "terratowns_access_token" {
  description = "token to access terratowns "
  type        = string
}