terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    acme = {
      source = "vancluever/acme"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}
