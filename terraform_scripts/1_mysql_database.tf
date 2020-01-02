resource "azurerm_mysql_server" "mysql" {
  name                = "${azurerm_resource_group.group.name}-mysql-server"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  sku {
    capacity = 2
    family = "Gen5"
    name = "B_Gen5_2"
    tier = "Basic"
  }

  storage_profile {
    storage_mb = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login = "developerjpl"
  administrator_login_password = "Esgi2020_ez"
  ssl_enforcement = "Enabled"
  version = "5.7"

  tags = {
    environment = "production"
    group       = azurerm_resource_group.group.name
  }
}

resource "azurerm_mysql_database" "mysql" {
  name                = "${azurerm_resource_group.group.name}-mysql"
  resource_group_name = azurerm_resource_group.group.name
  server_name         = azurerm_mysql_server.mysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "mysql" {
  name                = "${azurerm_resource_group.group.name}-mysql-firewall"
  resource_group_name = azurerm_resource_group.group.name
  server_name         = azurerm_mysql_server.mysql.name
  start_ip_address    = "212.195.35.58"
  end_ip_address      = "212.195.35.58"
}