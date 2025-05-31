variable "application" {
  description = "Name of the application to deploy"
  type        = string
}

variable "environment" {
  description = "Deployment Environment Name"
  type        = string
}

variable "admin_environment" {
  description = "Admin Environment Name"
  type        = string
}

variable "email_address" {
  description = "Email address for ACME account"
  type        = string
}
