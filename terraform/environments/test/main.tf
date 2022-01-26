provider "azurerm" {
  features {}
}

module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.project_name}-resources-${var.environment_name}"
  location             = var.location
  project              = var.project_name
}

module "network" {
  source               = "../../modules/network"
  location             = var.location
  resource_prefix      = "vnet"
  resource_group       = module.resource_group.resource_group_name
  vnet_address_space   = var.vnet_address_space
  project              = var.project_name
}