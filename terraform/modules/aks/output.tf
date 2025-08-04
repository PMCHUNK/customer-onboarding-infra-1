output "aks_name" {
  value = azurerm_kubernetes_cluster.k8_cluster.name
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8_cluster.kube_config_raw
  sensitive = true
}


output "aks_identity_principal_id" {
  value = azurerm_user_assigned_identity.aks-identity.principal_id
}

output "aks_identity_client_id" {
  value = azurerm_user_assigned_identity.aks-identity.client_id
}

output "aks_identity_tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

# for csi azure things

output "host" {
  value = azurerm_kubernetes_cluster.k8_cluster.kube_config[0].host
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8_cluster.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.k8_cluster.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.k8_cluster.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.k8_cluster.kubelet_identity[0].object_id
}