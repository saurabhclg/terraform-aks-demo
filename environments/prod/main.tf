resource "azurerm_resource_group" "rg" {
  name     = "rg-aks-prod"
  location = "Central India"
}

module "aks_prod" {
  source              = "../../modules/aks"
  cluster_name        = "aks-prod"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksprod"
  node_count          = 3
}
