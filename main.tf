terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}



# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}TFRG"
  location = var.location
  tags     = var.tags
}

# Create keyvault
module "TF_CreateKV" {
  source   = "./modules/TF_CreateKV"
  rgname   = azurerm_resource_group.rg.name
  location = var.location
}
