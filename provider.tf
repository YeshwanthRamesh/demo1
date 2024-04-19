terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
  subscription_id = "10b02461-a1c5-4026-95db-8fe031800318"
  tenant_id       = "476e21f0-3fe2-44c1-a0be-9f0865ad852b"
}

