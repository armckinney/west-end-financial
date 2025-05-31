data "azurerm_dns_zone" "this" {
  name                = var.dnz_zone.name
  resource_group_name = local.dns_zone_resource_group
}
