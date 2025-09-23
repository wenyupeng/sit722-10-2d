# sit722-10-2d/terraform/container-registry.tf

data "azurerm_container_registry" "existing_acr" {
  name                = "chriswen430acr"
  resource_group_name = "chriswen430-rg"
}
