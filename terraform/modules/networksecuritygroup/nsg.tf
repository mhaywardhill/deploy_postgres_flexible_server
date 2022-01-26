resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group
 
  tags = {
    project = var.project
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
   subnet_id                 = var.subnet_id
   network_security_group_id = azurerm_network_security_group.nsg.id
}