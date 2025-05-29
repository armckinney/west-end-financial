locals {
  location = "eastus"
  tags = {
    application = var.application
    environment = var.environment
  }
}
