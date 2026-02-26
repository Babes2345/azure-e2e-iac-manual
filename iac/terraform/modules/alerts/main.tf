resource "azurerm_monitor_action_group" "email" {
  name                = var.action_group_name
  resource_group_name = var.rg_platform_name
  short_name          = "agkv"

  email_receiver {
    name          = "primary"
    email_address = var.alert_email
  }

  tags = var.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "kv_failures" {
  name                = var.kv_alert_name
  resource_group_name = var.rg_platform_name
  location            = var.location

  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"
  severity             = 2
  enabled              = true

  scopes = [var.log_analytics_workspace_id]

  criteria {
    query = <<-KQL
AzureDiagnostics
| where ResourceType == "VAULTS"
| where ResultSignature has "Unauthorized" or ResultSignature has "Forbidden"
| count
KQL

    time_aggregation_method = "Count"
    operator                = "GreaterThanOrEqual"
    threshold               = 3
  }

  action {
    action_groups = [azurerm_monitor_action_group.email.id]
  }

  tags = var.tags
}

