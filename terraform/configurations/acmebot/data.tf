
data "azurerm_client_config" "this" {}

data "azurerm_key_vault" "this" {
  name                = local.admin_key_vault
  resource_group_name = local.admin_resource_group
}
