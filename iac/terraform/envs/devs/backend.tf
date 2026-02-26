terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-e2e"
    storage_account_name = "sttfe2e430806"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
