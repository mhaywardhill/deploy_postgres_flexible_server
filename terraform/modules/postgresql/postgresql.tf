resource "azurerm_postgresql_flexible_server" "main" {
  name                    = var.server_name
  resource_group_name     = var.resource_group
  location                = var.location
  version                 = "13"
  delegated_subnet_id     = var.delegated_subnet_id
  private_dns_zone_id     = var.private_dns_zone_id
  administrator_login     = var.db_username
  administrator_password  = var.db_password
  zone                    = "1"
  
  storage_mb = 32768
  
  sku_name   = "B_Standard_B1ms"
  
  tags = {
    project = var.project
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
   name     = "diagnosticSettings"
   log_analytics_workspace_id = var.log_analytics_workspace_id
   target_resource_id = azurerm_postgresql_flexible_server.main.id
   
  log { 
    category  = "PostgreSQLLogs"
    enabled   = true 

    retention_policy {
      enabled = false
    }
  }
  
  metric {
    category  = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }

  depends_on  = [
    azurerm_postgresql_flexible_server.main
  ]
}

resource "azurerm_postgresql_flexible_server_configuration" "configuration" {
    count               = length(var.server_parameters)
    server_id           = azurerm_postgresql_flexible_server.main.id
    name                = var.server_parameters[count.index].key
    value               = var.server_parameters[count.index].value

    depends_on          = [
      azurerm_postgresql_flexible_server.main
    ]
  
}