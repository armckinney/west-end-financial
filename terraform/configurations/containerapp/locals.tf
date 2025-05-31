locals {
  location                = "eastus"
  organization            = "armckinney"
  letsencrypt_email       = "armck.phantom@gmail.com"
  dns_zone_resource_group = join(".", ["rg", var.dnz_zone.application, var.dnz_zone.environment])
  tags = {
    application = var.application
    environment = var.environment
  }
}
