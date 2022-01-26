resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "mymachine"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    source_port_range          = "*"
    destination_port_range     = "22"
    protocol			 = "TCP"
    source_address_prefix      = var.my_public_ip
    destination_address_prefix = "*"
  }
 
  tags = {
    project = var.project
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
   subnet_id                 = var.subnet_id
   network_security_group_id = azurerm_network_security_group.nsg.id
}