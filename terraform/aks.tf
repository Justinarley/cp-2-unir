resource "azurerm_kubernetes_cluster" "cp2_aks" { # Crea el clúster AKS en Azure

  # Nombre y ubicación del clúster
  name                = "cp2-aks-unir-2026"
  location            = azurerm_resource_group.cp2_rg.location
  resource_group_name = azurerm_resource_group.cp2_rg.name
  dns_prefix          = "akscp2unir2026"


  # Nodo principal del clúster
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B4ls_v2"
  }


  # Identidad administrada para acceso a recursos
  identity {
    type = "SystemAssigned"
  }


  # Etiquetas para identificar el entorno
  tags = {
    environment = "caso_practico_2"
  }

}


# Permite que AKS lea imágenes del ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id = azurerm_kubernetes_cluster.cp2_aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope = azurerm_container_registry.cp2_rg.id
}



# Exporta el kubeconfig para usarlo con Ansible
resource "local_file" "kubeconfig" {
  content         = azurerm_kubernetes_cluster.cp2_aks.kube_config_raw
  filename        = "${path.module}/../ansible/kubeconfig"
  file_permission = "0600"
}