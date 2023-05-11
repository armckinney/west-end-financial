variable "environment" {
  description = "Deployment Environment Name"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Deployment Environment Location"
  type        = string
  default     = "eastus"
}


locals {
  application            = "westendfinancial"
  application_dockerfile = "../../app/Dockerfile"
  tags = {
    application = local.application
    environment = var.environment
  }
}
