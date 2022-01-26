output "public_ip_address_id" {
  value = azurerm_public_ip.main.id
}

output "vm_public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}