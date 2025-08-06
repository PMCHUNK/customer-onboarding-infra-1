data "azurerm_client_config" "current" {

}



data "azuread_service_principal" "terraform_spn" {
  display_name = "teraaform"
}

# data "local_file" "dockerconfigjson" {
#   filename = "${path.module}/.dockerconfigjson"
# }


resource "azurerm_key_vault" "my-kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
  purge_protection_enabled = false
  soft_delete_retention_days= 7


}



resource "azurerm_key_vault_access_policy" "self_access" {
  key_vault_id = azurerm_key_vault.my-kv.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get","List","Set","Delete","Purge"
  ]
}

# resource "azurerm_key_vault_access_policy" "aks_kv_acess" {
#   key_vault_id = azurerm_key_vault.my-kv.id
#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = var.aks_identity_principal_id

#   secret_permissions = [
#     "Get","List","Set","Delete","Purge"
#   ]
#   depends_on = [ azurerm_key_vault.my-kv ]
# }

resource "azurerm_key_vault_access_policy" "aks_mi_policy" {
  key_vault_id = azurerm_key_vault.my-kv.id

  tenant_id = var.aks_mi_tenant_id
  object_id = var.aks_mi_principal_id

  secret_permissions = [
    "Get","List","Set","Delete","Purge"
  ]
}

resource "azurerm_role_assignment" "kv_reader" {
  scope                = azurerm_key_vault.my-kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.aks_identity_principal_id
}


resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = "Abhi@123"
  key_vault_id = azurerm_key_vault.my-kv.id
  depends_on = [ azurerm_key_vault_access_policy.self_access ]
 
}

resource "azurerm_key_vault_secret" "db_host" {
  name         = "db-host"
  value        = "customer-pg-db0.postgres.database.azure.com"
  key_vault_id = azurerm_key_vault.my-kv.id
  depends_on = [ azurerm_key_vault_access_policy.self_access ]
 
}

resource "azurerm_key_vault_secret" "db_name" {
  name         = "db-name"
  value        = "customer_db"
  key_vault_id = azurerm_key_vault.my-kv.id
  depends_on = [ azurerm_key_vault_access_policy.self_access ]
 
}

resource "azurerm_key_vault_secret" "db_user" {
  name         = "db-user"
  value        = "psqladmin"
  key_vault_id = azurerm_key_vault.my-kv.id
  depends_on = [ azurerm_key_vault_access_policy.self_access ]
 
}

resource "azurerm_key_vault_secret" "db_port" {
  name         = "db-port"
  value        = "5432"
  key_vault_id = azurerm_key_vault.my-kv.id
  depends_on = [ azurerm_key_vault_access_policy.self_access ]
 
}


# resource "azurerm_key_vault_secret" "dockerconfig" {
#   name         = "dockerconfigjson"
#   value        = data.local_file.dockerconfigjson.content
#   key_vault_id = azurerm_key_vault.my-kv.id
# }
