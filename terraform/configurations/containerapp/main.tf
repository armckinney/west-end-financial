# backend config: https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
terraform {
  backend "azurerm" {
    container_name = "terraform"
    key            = "/westendfinancial/dev.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
