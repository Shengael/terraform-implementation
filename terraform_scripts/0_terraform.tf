terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = ">=1.30.0"
  }
}

provider "azurerm" {
  version = ">=1.30.0"

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

resource "azurerm_resource_group" "db" {
  name     = "jpldb"
  location = "centralus"
}

resource "azurerm_resource_group" "bus" {
  location = "centralus"
  name     = "jplbus"
}

resource "azurerm_resource_group" "api" {
  location = "centralus"
  name     = "jplapi"
}

resource "azurerm_resource_group" "function" {
  name     = "jplfunction"
  location = "centralus"
}

resource "azurerm_resource_group" "front" {
  location = "centralus"
  name     = "jplfront"
}


locals {
  db_name     = "${azurerm_resource_group.db.name}-mysql"
  db_user     = "developerjpl"
  db_password = "Esgi2020_ez"
  image_path  = "jplproject/front"
}