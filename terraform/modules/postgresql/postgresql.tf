resource "azurerm_postgresql_flexible_server" "main" {
  name                    = var.server_name
  resource_group_name     = var.resource_group
  location                = var.location
  version                 = "12"
  delegated_subnet_id     = var.delegated_subnet_id
  private_dns_zone_id     = var.private_dns_zone_id
  administrator_login     = var.db_username
  administrator_password  = var.db_password
  zone                    = "1"
  
  storage_mb = 32768
  
  sku_name   = "GP_Standard_D4s_v3"
  
  tags = {
    project = var.project
  }
}

