resource "azurerm_resource_group" "cp2_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "caso_practico_2"
  }
}