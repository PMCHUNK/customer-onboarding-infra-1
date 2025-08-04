
resource "azurerm_linux_virtual_machine" "db-vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1ms"
  admin_username      = var.user_name
  admin_password = var.vm_password
  
  disable_password_authentication = false
  network_interface_ids = [
    var.network_interface_ids,
  ]
  


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}