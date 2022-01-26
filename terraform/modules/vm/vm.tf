resource "azurerm_network_interface" "main" {
  name                = "nic-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    public_ip_address_id          = var.public_ip_address_id
  }

  tags = {
    project = var.project
  }
}