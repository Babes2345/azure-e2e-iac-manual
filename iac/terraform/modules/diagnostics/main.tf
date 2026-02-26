resource "azurerm_monitor_diagnostic_setting" "webapp_diag" {
  count                      = var.web_app_id == null || var.web_app_id == "" ? 0 : 1
  name                       = "webapp-diagnostics"
  target_resource_id         = var.web_app_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AppServiceHTTPLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}



resource "azurerm_monitor_diagnostic_setting" "kv_diag" {
  name                       = "kv-diagnostics"
  target_resource_id         = var.key_vault_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

