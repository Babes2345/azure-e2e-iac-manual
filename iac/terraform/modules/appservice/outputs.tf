output "web_app_id" {
  value = azurerm_windows_web_app.this.id
}

output "web_app_name" {
  value = azurerm_windows_web_app.this.name
}

output "web_app_principal_id" {
  value = azurerm_windows_web_app.this.identity[0].principal_id
}

output "slot_id" {
  value       = var.enable_slot ? azurerm_windows_web_app_slot.staging[0].id : null
  description = "Slot resource id (null if enable_slot=false)."
}

output "slot_principal_id" {
  value       = var.enable_slot ? azurerm_windows_web_app_slot.staging[0].identity[0].principal_id : null
  description = "Slot principal id (null if enable_slot=false)."
}
