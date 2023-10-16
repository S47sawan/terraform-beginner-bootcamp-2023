#----------------------------------------------------------------------------------------------------------------------------
# Declare Variables
#----------------------------------------------------------------------------------------------------------------------------
variable "teacherseat_user_uuid" {
  description = "User UUID"
  type        = string
}
variable "pacman" {
  type = object({
    public_path     = string
    content_version = number
  })
}
variable "cook" {
  type        = object({
  public_path = string
  content_version = number
  })
}
variable "terratowns_endpoint" {
  description = "point of access to terratowns"
  type        = string
}
variable "terratowns_access_token" {
  description = "token to access terratowns "
  type        = string
}