terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.27"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraform-state"
    storage_account_name = "terraformsg4657"
    container_name = "statefile"
    key = "terraform.tfstate"
  }

  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
}
