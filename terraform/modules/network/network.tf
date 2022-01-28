resource "azurerm_virtual_network" "main" {
  name                 = "vnet-${var.project}-${var.environment_name}"
  address_space        = var.address_space
  location             = var.location
  resource_group_name  = var.resource_group

  tags = {
    project = var.project
  }
}

/*
Delegated subnet for postgres
*/
resource "azurerm_subnet" "postgres" {
  name                 = "snet-${var.project}-postgres-${var.environment_name}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefixes1
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "vm" {
  name                 = "snet-${var.project}-vm-${var.environment_name}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefixes2
}


/*
Private DNS zone integration is required to connect to your Flexible Server 
in virtual network using server name (fully qualified domain name).
*/

resource "azurerm_private_dns_zone" "main" {
  name                = "${var.project}-${var.environment_name}.postgres.database.azure.com"
  resource_group_name = var.resource_group
  
  tags = {
    project = var.project
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  name                  = "${var.project}_dns_zone_link-${var.environment_name}"
  private_dns_zone_name = azurerm_private_dns_zone.main.name
  virtual_network_id    = azurerm_virtual_network.main.id
  resource_group_name   = var.resource_group
  
  tags = {
    project = var.project
  }
}