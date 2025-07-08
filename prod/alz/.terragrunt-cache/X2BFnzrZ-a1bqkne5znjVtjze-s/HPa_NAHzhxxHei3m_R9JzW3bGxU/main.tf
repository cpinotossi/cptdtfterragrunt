terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

variable "subscription_id" {
  description = "A prefix used for all resources in this example."
  type        = string
}

variable "prefix" {
  description = "A prefix used for all resources in this example."
  type        = string
}

variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
  default     = "Germany West Central"
}

variable "Environment" {
  description = "Environment for the resources."
  type        = string
  default     = "prod"
  validation {
    condition     = contains(["prod", "dev"], var.Environment)
    error_message = "Environment must be one of: prod, dev"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.prefix
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.prefix
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    "Environment"      = var.Environment
  }
}

# branch1_subnet_0    = "172.16.0.0/24"
resource "azurerm_subnet" "subnet" {
  name                 = var.prefix
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

