<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.10.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_keyvault_acmebot"></a> [keyvault\_acmebot](#module\_keyvault\_acmebot) | shibayan/keyvault-acmebot/azurerm | 3.1.3 |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.30.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.30.0/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_environment"></a> [admin\_environment](#input\_admin\_environment) | Admin Environment Name | `string` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | Name of the application to deploy | `string` | n/a | yes |
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | Email address for ACME account | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment Environment Name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->