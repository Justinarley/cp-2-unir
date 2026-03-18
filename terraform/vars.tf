variable "location" {
  description = "Región de Azure"
  default = "mexicocentral"
}


variable "resource_group_name" {
  description = "Grupo de recursos"
  default = "rg-caso2"
}


variable "network_name" {
  description = "Red virtual"
  default = "vnet1"
}


variable "vm_size" {
  description = "Tamaño de VM"
  default = "Standard_B2as_v2"
}


variable "subnet_name" {
  description = "Subred"
  default = "subnet1"
}

variable "admin_username" {
  description = "Usuario admin de VM"
  default = "azurecp2admin"
}

variable "subscription_id" {
  description = "ID de suscripción"
}