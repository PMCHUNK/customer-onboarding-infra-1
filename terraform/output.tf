output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "resource_group_location" {
  value = module.resource_group.resource_group_location
}

output "acr_name" {
  value = module.acr.acr_name
}
output "acr_login_server" {
  value=module.acr.acr_login_server
}

output "upload_url" {
  value=module.storage_account.upload_url
}
output "aks_identity_principal_id" {
  value=module.aks.aks_identity_principal_id
}

output "aks_clinet_id" {
  value=module.aks.aks_identity_client_id
}

output "db_subnet_id"{
  value=module.vnet.db_subnet_id
}
