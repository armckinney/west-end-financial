resource "azurerm_resource_group" "application" {
  name     = join("-", ["rg", local.application, var.environment])
  location = var.location
  tags     = local.tags
}

resource "azurerm_container_registry" "application" {
  name                = "acr${local.application}${var.environment}"
  depends_on          = [azurerm_resource_group.application]
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  sku                 = "Basic"
  tags                = local.tags
}

# Login into ACR and build/push image
# Note: this could potentially be done using: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs
resource "null_resource" "docker_push_build" {
  depends_on = [azurerm_container_registry.application]
  provisioner "local-exec" {
    command = <<-EOT
        az acr login --name ${azurerm_container_registry.application.name}
        docker build --push --quiet \
            -t ${azurerm_container_registry.application.login_server}/${local.application}:latest \
            -f ${local.application_dockerfile} ../../
      EOT
  }
}

resource "azurerm_log_analytics_workspace" "application" {
  name                = join("-", ["log", local.application, var.environment])
  depends_on          = [azurerm_resource_group.application]
  resource_group_name = azurerm_resource_group.application.name
  location            = azurerm_resource_group.application.location
  tags                = local.tags
}

resource "azurerm_container_app_environment" "application" {
  name                       = join("-", ["cae", local.application, var.environment])
  depends_on                 = [azurerm_resource_group.application, azurerm_log_analytics_workspace.application]
  resource_group_name        = azurerm_resource_group.application.name
  location                   = azurerm_resource_group.application.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.application.id
  tags                       = local.tags
}


resource "azurerm_container_app" "application" {
  name                         = join("-", ["ca", local.application, var.environment])
  depends_on                   = [azurerm_resource_group.application, azurerm_container_app_environment.application, null_resource.docker_push_build]
  resource_group_name          = azurerm_resource_group.application.name
  container_app_environment_id = azurerm_container_app_environment.application.id
  revision_mode                = "Single"
  tags                         = local.tags

  ingress {
    external_enabled           = true
    allow_insecure_connections = true
    target_port                = 8008
    traffic_weight {
      percentage = 100
    }
  }

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    min_replicas = 0
    max_replicas = 1
  }

  # secret {
  #   name  = join("-", ["cas", azurerm_container_registry.application.name, "pw"])
  #   value = azurerm_container_registry.application.admin_password
  # }

  # registry {
  #   server               = azurerm_container_registry.application.login_server
  #   username             = azurerm_container_registry.application.admin_username
  #   password_secret_name = join("-", ["cas", azurerm_container_registry.application.name, "pw"])
  # }

  # template {
  #   container {
  #     name   = join("-", ["cntr", local.application, var.environment])
  #     image  = "${azurerm_container_registry.application.login_server}/${local.application}:latest"
  #     cpu    = 0.5
  #     memory = "1Gi"
  #   }
  #   min_replicas = 0
  #   max_replicas = 10
  # }
}
