resource "azurerm_container_registry" "cp2_rg" {
  name                = "acrcp2unir2026"
  resource_group_name = azurerm_resource_group.cp2_rg.name
  location            = azurerm_resource_group.cp2_rg.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    environment = "caso_practico_2"
  }
}