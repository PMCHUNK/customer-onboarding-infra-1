

module "resource_group" {
    source = "./modules/resource_group"
    name= var.resource_group_name
    location = var.location
  
}

module "acr" {
  source = "./modules/acr"
  name="customeronbordingacr"
  resource_group_name = module.resource_group.resource_group_name
  location = module.resource_group.resource_group_location
  sku = "Premium"
  admin_enabled = true
}

module "vnet" {
  source = "./modules/vent"
  vent_name = "customer-onboarding-vent"
  address_space = "10.10.0.0/16"
  location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

module "aks" {
  source = "./modules/aks"
  aks_name = "customeronboarding-aks"
  location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix = "custon"
  node_count = 1
  vm_size = "standard_B2s"
  aks_subnet_id = module.vnet.aks_subnet_id
  acr_id = module.acr.acr_id
  depends_on = [ module.resource_group ]
}

module "storage_account" {
  source = "./modules/storage_account"
  storage_account_name = var.storage_account_name
  resource_group_name = module.resource_group.resource_group_name
  location = module.resource_group.resource_group_location

}

module "key_vault" {
  source = "./modules/keyvault"
  key_vault_name = var.key_vault_name
  resource_group_name = module.resource_group.resource_group_name
  location = module.resource_group.resource_group_location
  aks_identity_principal_id = module.aks.aks_identity_principal_id
  aks_mi_principal_id = module.aks.aks_identity_principal_id
  aks_mi_tenant_id = module.aks.aks_identity_tenant_id
  aks_identity_client_id = module.aks.aks_identity_client_id
}

module "postgres" {
  source = "./modules/db"
  resource_group_name = module.resource_group.resource_group_name
  location = module.resource_group.resource_group_location
  vnet_id = module.vnet.vnet_id
  subnet_id = module.vnet.db_subnet_id
  db_password = var.db_password
  db_name = var.db_name
  db_server_name = var.db_server_name
}

# module "db_vm" {
#   source = "./modules/vm_linux"
#   resource_group_name = module.resource_group.resource_group_name
#   location = module.resource_group.resource_group_location
#   network_interface_ids = module.vnet.vent_ni_id

# }


module "ingress" {
  source = "./modules/ingress"
}

module "csi_driver" {
  source = "./modules/CSI_driver"
}

# module "azure_provider" {
#   source     = "./modules/azure_provider"
#   depends_on = [module.csi_driver,
#   module.aks]
# }

module "kv_access_policy" {
  source           = "./modules/kv_access_policy"
  key_vault_id     = module.key_vault.id
  kubelet_identity = module.aks.kubelet_identity_object_id
  tenant_id     = data.azurerm_client_config.current.tenant_id
  object_id     = module.aks.kubelet_identity_object_id
}