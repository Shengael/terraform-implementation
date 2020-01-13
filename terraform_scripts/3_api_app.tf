resource "azurerm_app_service_plan" "main" {
  name                = "${azurerm_resource_group.api.name}-app-plan"
  location            = azurerm_resource_group.api.location
  resource_group_name = azurerm_resource_group.api.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${azurerm_resource_group.api.name}-api-service"
  location            = azurerm_resource_group.api.location
  resource_group_name = azurerm_resource_group.api.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    linux_fx_version = "NODE|10.14"
  }

  app_settings = {
    "DB_HOST"                     = azurerm_mysql_server.mysql.fqdn
    "DB_USER"                     = "${local.db_user}@${azurerm_mysql_server.mysql.name}"
    "DB_PASSWORD"                 = local.db_password
    "DB_PORT"                     = 3306
    "DB_NAME"                     = local.db_name
    "NAMESPACE_CONNECTION_STRING" = azurerm_servicebus_namespace.main.default_primary_connection_string
  }

  connection_string {
    name  = "Database"
    type  = "MySql"
    value = "Server=${azurerm_mysql_server.mysql.fqdn};Integrated Security=SSPI"
  }

  connection_string {
    name  = "AzureServiceBusConnectionString"
    type  = "ServiceBus"
    value = azurerm_servicebus_namespace.main.default_primary_connection_string
  }
}