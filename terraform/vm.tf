resource "tls_private_key" "ssh_key_cp2_vm" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_network_interface" "cp2_nic" {
  name                = "nic-cp2"
  location            = azurerm_resource_group.cp2_rg.location
  resource_group_name = azurerm_resource_group.cp2_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.cp2_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.cp2_vm_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "cp2_vm" {
  name                = "cp2-vm"
  resource_group_name = azurerm_resource_group.cp2_rg.name
  location            = azurerm_resource_group.cp2_rg.location
  size                = var.vm_size

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.cp2_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh_key_cp2_vm.public_key_openssh
  }

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

  tags = {
    environment = "caso_practico_2"
  }


}
