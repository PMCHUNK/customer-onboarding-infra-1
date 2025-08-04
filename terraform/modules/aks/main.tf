data "azurerm_client_config" "current" {}




locals {
  node_rg_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_kubernetes_cluster.k8_cluster.node_resource_group}"
}


resource "azurerm_kubernetes_cluster" "k8_cluster" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "cdx"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.aks_subnet_id
    os_disk_size_gb = 30
    type = "VirtualMachineScaleSets"
    temporary_name_for_rotation  = "tempdefault" 
  }
 

  
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks-identity.id]
  }
  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    load_balancer_sku = "standard"
  }
  oidc_issuer_enabled = true

  api_server_access_profile {
    authorized_ip_ranges = ["0.0.0.0/0"]
    } 
}

# resource "azurerm_kubernetes_cluster_node_pool" "usernp" {
#   name                  = "usernp"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.k8_cluster.id
#   vm_size               = var.vm_size
#   node_count            = var.node_count
#   vnet_subnet_id        = var.aks_subnet_id
#   os_disk_size_gb       = 30
#   mode                  = "User"
#   orchestrator_version  = azurerm_kubernetes_cluster.k8_cluster.kubernetes_version
# }


resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.k8_cluster.kubelet_identity[0].object_id

}

resource "azurerm_user_assigned_identity" "aks-identity" {
  name="aks-identity"
  resource_group_name = var.resource_group_name
  location = var.location
}

resource "azurerm_role_assignment" "uami_vmss_operator" {
  scope                = local.node_rg_id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.aks-identity.principal_id
}

# Assign Contributor role to the UAMI for attaching itself to VMSS
resource "azurerm_role_assignment" "uami_vmss_contributor" {
  scope                = local.node_rg_id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_user_assigned_identity.aks-identity.principal_id
}



