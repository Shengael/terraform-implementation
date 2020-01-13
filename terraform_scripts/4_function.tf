resource "azurerm_storage_account" "main" {
  name                     = "${azurerm_resource_group.function.name}sa"
  resource_group_name      = azurerm_resource_group.function.name
  location                 = azurerm_resource_group.function.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "function" {
  name                = "${azurerm_resource_group.function.name}-plan-function"
  location            = azurerm_resource_group.function.location
  resource_group_name = azurerm_resource_group.function.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "main" {
  name                      = "${azurerm_resource_group.function.name}-function"
  location                  = azurerm_resource_group.function.location
  resource_group_name       = azurerm_resource_group.function.name
  app_service_plan_id       = azurerm_app_service_plan.function.id
  storage_connection_string = azurerm_storage_account.main.primary_connection_string

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"        = "python",
    "AzureServiceBusConnectionString" = azurerm_servicebus_namespace.main.default_primary_connection_string
    "APPINSIGHTS_INSTRUMENTATIONKEY"  = azurerm_application_insights.function.instrumentation_key
  }

  site_config {
    always_on                 = true
    linux_fx_version          = "DOCKER|mcr.microsoft.com/azure-functions/python:2.0-python3.7-appservice"
    use_32_bit_worker_process = true
    websockets_enabled        = false
  }
  connection_string {
    name  = "AzureServiceBusConnectionString"
    type  = "ServiceBus"
    value = azurerm_servicebus_namespace.main.default_primary_connection_string
  }

}

resource "azurerm_application_insights" "function" {
  name                = "${azurerm_resource_group.function.name}-functioninsights"
  location            = azurerm_resource_group.function.location
  resource_group_name = azurerm_resource_group.function.name
  application_type    = "web"
}
