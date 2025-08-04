output "vnet_name" {
  value = azurerm_virtual_network.app-vent.name
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db.id
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm.id
}

output "vm_nsg_id" {
  value = azurerm_network_security_group.vm_nsg.id
}

output "vnet_id" {
 value= azurerm_virtual_network.app-vent.id 
}

output "vent_ni_id" {
  value = azurerm_network_interface.db_vm_ni.id
}

output "db_vm_public_ip" {
  value = azurerm_public_ip.db_vm_public_ip.ip_address
}