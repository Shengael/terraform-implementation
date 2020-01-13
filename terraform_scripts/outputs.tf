output "api_group_name" {
  value = azurerm_resource_group.api.name
}
output "func_group_name" {
  value = azurerm_resource_group.function.name
}

output "front_group_name" {
  value = azurerm_resource_group.front.name
}

output "bus_group_name" {
  value = azurerm_resource_group.bus.name
}

output "db_group_name" {
  value = azurerm_resource_group.db.name
}

output "api_service_name" {
  value = azurerm_app_service.main.name
}

output "api_url" {
  value = "https://${azurerm_app_service.main.default_site_hostname}"
}

output "function_name" {
  value = azurerm_function_app.main.name
}

output "front_service_name" {
  value = azurerm_app_service.front.name
}

output "registry_name" {
  value = azurerm_container_registry.front.name
}

output "registry_target" {
  value = "${azurerm_container_registry.front.login_server}/${local.image_path}"
}


