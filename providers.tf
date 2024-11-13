# Terraform Block
terraform {
  required_version = ">= 1.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1.0.0"
    }
  }
}

# Azure Resource Mangager Provider Block
provider "azurerm" {
  features {}
  tenant_id = var.tenant_id
}
  

# Azure Active Directory Provider Block
provider "azuread" {
  tenant_id = var.tenant_id
}
