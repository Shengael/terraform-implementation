resource "azurerm_mysql_server" "mysql" {
  name                = "${azurerm_resource_group.db.name}-mysql-server"
  location            = azurerm_resource_group.db.location
  resource_group_name = azurerm_resource_group.db.name
  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login = local.db_user
  administrator_login_password = local.db_password
  ssl_enforcement = "Disabled"
  version = "5.7"

  tags = {
    environment = "production"
    group       = azurerm_resource_group.db.name
  }
}

resource "azurerm_mysql_database" "mysql" {
  name                = local.db_name
  resource_group_name = azurerm_resource_group.db.name
  server_name         = azurerm_mysql_server.mysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "mysql" {
  name                = "${azurerm_resource_group.db.name}-mysql-firewall"
  resource_group_name = azurerm_resource_group.db.name
  server_name         = azurerm_mysql_server.mysql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}