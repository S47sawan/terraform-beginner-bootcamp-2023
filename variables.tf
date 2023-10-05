#----------------------------------------------------------------------------------------------------------------------------
# Declare Variables
#----------------------------------------------------------------------------------------------------------------------------
variable "user_uuid" {
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