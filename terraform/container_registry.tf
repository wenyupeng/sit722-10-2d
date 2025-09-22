# sit722-10-2d/terraform/container-registry.tf

resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}
