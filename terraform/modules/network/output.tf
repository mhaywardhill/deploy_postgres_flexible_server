output "postgres_subnet_id" {
  value = azurerm_subnet.postgres.id
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm.id
}


output "dns_zone_id" {
  value = azurerm_private_dns_zone.main.id
}