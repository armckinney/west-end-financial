locals {
  location             = "eastus"
  admin_application    = "admins"
  email_address        = "armck.phantom@gmail.com"
  admin_resource_group = join("-", ["rg", var.local.admin_application, var.admin_environment])
  admin_key_vault      = join("-", ["kv", "${var.local.admin_application}s", var.admin_environment])

  resource_group_name = join("-", ["rg", var.application, var.environment])
}
