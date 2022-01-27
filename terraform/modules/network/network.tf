resource "azurerm_virtual_network" "main" {
  name                 = "vnet-${var.project}"
  address_space        = var.address_space
  location             = var.location
  resource_group_name  = var.resource_group

  tags = {
    project = var.project
  }
}

resource "azurerm_subnet" "main1" {
  name                 = "snet-${var.project}1"
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

resource "azurerm_subnet" "main2" {
  name                 = "snet-${var.project}2"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefixes2
}


/*
Private DNS zone integration is required to connect to your Flexible Server 
in virtual network using server name (fully qualified domain name).
*/
resource "azurerm_private_dns_zone" "main" {
  name                = "${var.project}.postgres.database.azure.com"
  resource_group_name = var.resource_group
  
  tags = {
    project = var.project
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  name                  = "fsexampleVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.main.name
  virtual_network_id    = azurerm_virtual_network.main.id
  resource_group_name   = var.resource_group
  
  tags = {
    project = var.project
  }
}