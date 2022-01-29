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
  address_prefixes1    = ["10.0.2.0/24"]
  address_prefixes2    = ["10.0.3.0/24"]
  project              = var.project_name
  environment_name     = var.environment_name
}

module "nsg" {
  source              = "../../modules/networksecuritygroup"
  location            = var.location
  resource_group      = module.resource_group.resource_group_name
  postgres_subnet_id  = module.network.postgres_subnet_id
  vm_subnet_id        = module.network.vm_subnet_id
  project             = var.project_name
  my_public_ip        = var.my_public_ip
  environment_name    = var.environment_name
  depends_on = [module.network]
}

module "publicip" {
  source              = "../../modules/publicip"
  location            = var.location
  resource_group      = module.resource_group.resource_group_name
  project             = var.project_name
  environment_name    = var.environment_name
  depends_on = [module.network]
}

module "vm" {
  source                 = "../../modules/vm"
  location              = var.location
  resource_group        = module.resource_group.resource_group_name
  subnet_id             = module.network.vm_subnet_id
  public_ip_address_id  = module.publicip.public_ip_address_id
  project               = var.project_name
  vm_username           = var.vm_username
  environment_name      = var.environment_name
  depends_on = [module.nsg]
}

module "postgresql" {
  source                = "../../modules/postgresql"
  location              = var.location
  resource_group        = module.resource_group.resource_group_name
  server_name	          = "${var.project_name}-pgfs-${var.environment_name}"
  db_username           = var.db_username
  db_password           = var.db_password
  project               = var.project_name
  delegated_subnet_id   = module.network.postgres_subnet_id
  private_dns_zone_id   = module.network.dns_zone_id
  depends_on = [module.nsg]
}
module "log_analytics" {
  source                = "../../modules/log_analytics"
  location              = var.location
  resource_group        = module.resource_group.resource_group_name
  workspace_name        = "${var.project_name}-logs-${var.environment_name}"
  project               = var.project_name
}