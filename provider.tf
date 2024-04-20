terraform {
  required_version = ">=0.12"
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version= "~>2.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.8"
    } 
  }
}
provider "azuread" {
  use_msi = true
  subscription_id = "10b02461-a1c5-4026-95db-8fe031800318"
  tenant_id       = "476e21f0-3fe2-44c1-a0be-9f0865ad852b"
}

provider "azurerm" {
  features {}
  use_msi = true
  subscription_id = "10b02461-a1c5-4026-95db-8fe031800318"
  tenant_id       = "476e21f0-3fe2-44c1-a0be-9f0865ad852b"
}

