resource "azurerm_virtual_network" "main" {
  name                 = "vnet-${var.project}"
  address_space        = var.address_space
  location             = var.location
  resource_group_name  = var.resource_group

  tags = {
    project = var.project
  }
}

resource "azurerm_subnet" "main" {
  name                 = "snet-${var.project}"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefixes
}