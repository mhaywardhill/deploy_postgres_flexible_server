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
  resource_group       = module.resource_group.resource_group_name
  address_space        = ["10.0.0.0/16"]
  address_prefixes     = ["10.0.2.0/24"]
  project              = var.project_name
}

module "publicip" {
  source           = "../../modules/publicip"
  location         = var.location
  resource_group   = module.resource_group.resource_group_name
  project              = var.project_name
}