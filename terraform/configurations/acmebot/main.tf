terraform {
  required_version = "1.10.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
  }
}

# todo: app role auth & dns config
# - https://github.com/shibayan/keyvault-acmebot/wiki/App-Role-based-authorization
# - https://github.com/shibayan/keyvault-acmebot/wiki/DNS-Provider-Configuration

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
