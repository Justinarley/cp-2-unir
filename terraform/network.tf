resource "azurerm_virtual_network" "cp2_vnet" {
  name                = "cp2-vnet-unir-2026"
  location            = azurerm_resource_group.cp2_rg.location
  resource_group_name = azurerm_resource_group.cp2_rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "caso_practico_2"
  }
}

resource "azurerm_subnet" "cp2_subnet" {
  name                 = "cp2-subnet-unir-2026"
  resource_group_name  = azurerm_resource_group.cp2_rg.name
  virtual_network_name = azurerm_virtual_network.cp2_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "Allow-SSH"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.cp2_rg.name
  network_security_group_name = azurerm_network_security_group.vm_nsg.name
}

resource "azurerm_network_security_rule" "http" {
  name                        = "Allow-HTTP"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.cp2_rg.name
  network_security_group_name = azurerm_network_security_group.vm_nsg.name
}
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "cp2-vm-nsg-unir-2026"
  location            = azurerm_resource_group.cp2_rg.location
  resource_group_name = azurerm_resource_group.cp2_rg.name
}

resource "azurerm_network_interface_security_group_association" "vm_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.cp2_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

resource "azurerm_public_ip" "cp2_vm_ip" {
  name                = "cp2-vm-ip-unir-2026"
  location            = azurerm_resource_group.cp2_rg.location
  resource_group_name = azurerm_resource_group.cp2_rg.name
  allocation_method   = "Static"

  tags = {
    environment = "caso_practico_2"
  }
}

