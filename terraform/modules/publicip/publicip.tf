resource "azurerm_public_ip" "main" {
  name                = "pip-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"

  tags = {
    project = var.project
  }
}