# sit722-10-2d/terraform/kubernetes-cluster.tf

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  dns_prefix          = var.prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  # Use a system‐assigned managed identity
  identity {
    type = "SystemAssigned"
  }
}


# Grant AKS permission to pull images from the existing ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.existing_acr.id
  skip_service_principal_aad_check = true
}
