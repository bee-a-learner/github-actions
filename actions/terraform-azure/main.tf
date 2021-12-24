terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }

#    backend "azurerm" {
#     resource_group_name  = "StorageAccount-ResourceGroup"
#     storage_account_name = "abcd1234"
#     container_name       = "tfstate"
#     key                  = "prod.terraform.tfstate"
#   }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "West Europe"
}