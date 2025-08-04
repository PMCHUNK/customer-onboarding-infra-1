
resource "azurerm_private_dns_zone" "postgress" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "postgres_vent_link" {
  name                  = "postgres-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgress.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
  registration_enabled = false
}

# resource "azurerm_virtual_network" "db-vent" {
#   name                = "db-vent"
#   location            = "Central India"
#   resource_group_name = var.resource_group_name
#   address_space       = ["10.0.0.0/16"]

# }

# resource "azurerm_subnet" "db-subnet" {
#   name                 = "db-subnet1"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.db-vent.name
#   address_prefixes     = ["10.0.1.0/24"]
#   delegation {
#     name = "db-delegation"
#     service_delegation {
#       name = "Microsoft.DBforPostgreSQL/flexibleServers"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action",]
#     }
#     }

# }

resource "azurerm_postgresql_flexible_server" "db" {
  name                          = var.db_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12"
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.postgress.id
  public_network_access_enabled = false
  administrator_login           = "psqladmin"
  administrator_password        = var.db_password


  storage_mb   = 32768
  storage_tier = "P4"

  sku_name   = "GP_Standard_D2s_v3"

zone = "2"

 high_availability {
  mode                      = "ZoneRedundant"
  standby_availability_zone = "1"
 }

 authentication {
   password_auth_enabled = true
 }

}


resource "azurerm_postgresql_flexible_server_database" "app_db" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.db.id
  collation = "en_US.utf8"
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = true
#   }
}