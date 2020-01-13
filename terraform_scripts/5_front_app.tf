resource "azurerm_container_registry" "front" {
  name                = "${azurerm_resource_group.front.name}registery"
  resource_group_name = azurerm_resource_group.front.name
  location            = azurerm_resource_group.front.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_app_service_plan" "front" {
  name                = "${azurerm_resource_group.front.name}-plan"
  location            = azurerm_resource_group.front.location
  resource_group_name = azurerm_resource_group.front.name
  reserved            = true
  kind                = "Linux"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Create an Azure Web App for Containers in that App Service Plan
resource "azurerm_app_service" "front" {
  name                = "${azurerm_resource_group.front.name}-dockerapp"
  location            = azurerm_resource_group.front.location
  resource_group_name = azurerm_resource_group.front.name
  app_service_plan_id = azurerm_app_service_plan.front.id

  # Do not attach Storage by default
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    # Settings for private Container Registires
    DOCKER_REGISTRY_SERVER_URL      = azurerm_container_registry.front.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.front.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.front.admin_password
  }

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.front.login_server}/${local.image_path}:latest"
    always_on        = "true"
  }

}
