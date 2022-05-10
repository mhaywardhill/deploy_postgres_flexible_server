resource "azurerm_network_security_group" "vm" {
  name                = "nsg-${var.project}-vm-${var.environment_name}"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "mymachine"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    source_port_range          = "*"
    destination_port_range     = "22"
    protocol			 = "Tcp"
    source_address_prefix      = var.my_public_ip
    destination_address_prefix = "*"
  }
 
  tags = {
    project = var.project
  }
}

resource "azurerm_network_security_group" "postgres" {
  name                = "nsg-${var.project}-postgres-${var.environment_name}"
  location            = var.location
  resource_group_name = var.resource_group
 
  tags = {
    project = var.project
  }
}

resource "azurerm_subnet_network_security_group_association" "vm" {
   subnet_id                 = var.vm_subnet_id 
   network_security_group_id = azurerm_network_security_group.vm.id
}

resource "azurerm_subnet_network_security_group_association" "postgres" {
   subnet_id                 = var.postgres_subnet_id
   network_security_group_id = azurerm_network_security_group.postgres.id
}