#----------------------------------------------------------------------------------------------------------------------------
# Declare Variables
#----------------------------------------------------------------------------------------------------------------------------
variable "teacherseat_user_uuid" {
  description = "User UUID"
  type        = string
}
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}
variable "index_html_filepath" {
  description = "The file path for index.html"
  type        = string
}
variable "error_html_filepath" {
  description = "The file path for index.html"
  type        = string
}
variable "content_version" {
  description = "Version number for content"
  type        = number
}
variable "assets_path" {
  description = "Path to assets folder"
  type        = string
}
variable "terratowns_endpoint" {
  description = "point of access to terratowns"
  type        = string
}
variable "terratowns_access_token" {
  description = "token to access terratowns "
  type        = string
}