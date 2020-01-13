  resource "azurerm_servicebus_namespace" "main" {
  name                = "${azurerm_resource_group.bus.name}-namespace"
  location            = azurerm_resource_group.bus.location
  resource_group_name = azurerm_resource_group.bus.name
  sku                 = "Basic"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_servicebus_queue" "main" {
  name                = "${azurerm_resource_group.bus.name}-queue"
  resource_group_name = azurerm_resource_group.bus.name
  namespace_name      = azurerm_servicebus_namespace.main.name
}