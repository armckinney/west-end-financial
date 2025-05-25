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
