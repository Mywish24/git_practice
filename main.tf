terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.80.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features{}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}
