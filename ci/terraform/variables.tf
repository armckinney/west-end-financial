variable "tenant_id" {
  description = "Deployment Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "Deployment Azure Subscription ID"
  type        = string
  sensitive   = true
}

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
  application                  = "westendfinancial"
  workspace_root               = "/workspaces/west-end-financial"
  app_dockerfile_relative_path = "./app/Dockerfile"
  app_checksum                 = sha1(join("", [for f in fileset(path.module, "../../app/*") : filesha1(f)]))
  tags = {
    application = local.application
    environment = var.environment
  }
}
