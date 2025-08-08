resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
#   georeplications {
#     location                = "East US"
#     zone_redundancy_enabled = true
#     tags                    = {}
#   }
#   georeplications {
#     location                = "North Europe"
#     zone_redundancy_enabled = true
#     tags                    = {}
#   }
 }
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = "1329ae70-11c5-4b50-86a3-217318dc6c29"
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}