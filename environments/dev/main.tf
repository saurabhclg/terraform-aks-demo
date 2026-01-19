resource "azurerm_resource_group" "rg" {
  name     = "rg-aks-dev"
  location = "Central India"
}

module "aks_dev" {
  source              = "../../modules/aks"
  cluster_name        = "aks-dev"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksdev"
  node_count          = 1
}
