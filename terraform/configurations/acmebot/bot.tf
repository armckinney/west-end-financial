module "keyvault_acmebot" {
  source  = "shibayan/keyvault-acmebot/azurerm"
  version = "3.1.3"

  app_base_name       = join("-", ["ca", var.application, var.environment])
  resource_group_name = local.resource_group_name
  location            = local.location
  mail_address        = local.email_address
  vault_uri           = data.azurerm_key_vault.this.vault_uri

  azure_dns = {
    subscription_id = data.azurerm_client_config.this.subscription_id
  }
}
