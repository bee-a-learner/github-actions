terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.client_tenant_id
}


# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "West Europe"
}