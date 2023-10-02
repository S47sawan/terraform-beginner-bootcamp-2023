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
