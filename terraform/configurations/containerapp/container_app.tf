resource "azurerm_container_app_environment" "this" {
  name                       = join("-", ["cae", var.application, var.environment])
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  tags                       = local.tags
}

resource "azurerm_container_app" "this" {
  name                         = join("-", ["ca", var.application, var.environment])
  resource_group_name          = azurerm_resource_group.this.name
  container_app_environment_id = azurerm_container_app_environment.this.id
  revision_mode                = "Single"
  tags                         = local.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_app.id]
  }

  ingress {
    external_enabled = true
    target_port      = 8008
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  registry {
    server   = var.container_registry
    identity = azurerm_user_assigned_identity.this.id
  }

  template {
    container {
      name   = join("-", ["cntr", var.application, var.environment])
      image  = "${var.container_registry}/${var.container_name}:${var.image_tag}"
      cpu    = 0.5
      memory = "1Gi"
    }
    min_replicas = 0
    max_replicas = 10
  }
}
