resource "azurerm_public_ip" "main" {
  name                = "pip-${var.project}-${var.environment_name}"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"

  tags = {
    project = var.project
  }
}