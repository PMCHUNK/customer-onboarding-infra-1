resource "azurerm_storage_account" "my-sg" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = true
}

resource "azurerm_storage_container" "my-container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.my-sg.id
  container_access_type = "blob"
}