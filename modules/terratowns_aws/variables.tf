#----------------------------------------------------------------------------------------------------------------------------
# Declare Variables
#----------------------------------------------------------------------------------------------------------------------------
variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "Invalid UUID format. The UUID must be in the format 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'."
  }
}
# variable "bucket_name" {
#   description = "The name of the S3 bucket"
#   type        = string

#   validation {
#     condition     = (
#       length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && 
#       can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
#     )
#     error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
#   }
# }
variable "public_path" {
  description = "The file path for the public directory"
  type        = string
}

variable "content_version" {
  description = "Version number for content"
  type        = number
  validation {
    condition     = var.content_version >= 1 && ceil(var.content_version) == floor(var.content_version)
    error_message = "content_version must be a positive integer starting at 1."
  }
  default     = 1 # You can set a default value if needed.
}
# variable "pacman_public_path" {
#   description = "The file path for the public directory"
#   type        = string
# }
# variable "cook_public_path" {
#   description = "The file path for the public directory"
#   type        = string
# }

