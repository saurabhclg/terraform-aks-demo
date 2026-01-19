terraform {
  backend "azurerm" {
    resource_group_name  = "devops-demo"
    storage_account_name = "devopsdemoabb"
    container_name       = "tfstate"
    key                  = "dev/aks.tfstate"
  }
}
