resource "azurerm_user_assigned_identity" "this" {
  name                = join("-", ["id", var.application, var.environment])
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags
}
