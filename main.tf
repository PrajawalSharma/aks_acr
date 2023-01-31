resource "azurerm_resource_group" "rg" {
  name     = "terraform"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                             = "aks-cluster"
  location                         = "eastus"
  resource_group_name              = azurerm_resource_group.rg.name
  http_application_routing_enabled = true
  dns_prefix                       = "aks-cluster"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_container_registry" "acr" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "containerreg3645"
  location            = "eastus"
  sku                 = "Basic"
}

resource "azurerm_role_assignment" "role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}