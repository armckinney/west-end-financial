# backend config: https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
terraform {
  backend "local" {
    path = "./tfstate/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.55.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  tenant_id       = "ef575030-1424-4ed8-b83c-12c533d879ab"
  subscription_id = "956f6726-ce03-482e-8b0d-a3af7bfa51a2"
}
