resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  resource_group_name = var.rg_workload_name
  location            = var.location

  os_type  = "Windows"
  sku_name = "F1"

  tags = var.tags
}

resource "azurerm_windows_web_app" "this" {
  name                = var.web_app_name
  resource_group_name = var.rg_workload_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = false
  }

  app_settings = {
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.app_insights_connection_string
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.app_insights_instrumentation_key
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
  }

  tags = var.tags
}

resource "azurerm_windows_web_app_slot" "staging" {
  count          = var.enable_slot ? 1 : 0
  name           = var.slot_name
  app_service_id = azurerm_windows_web_app.this.id

  identity {
    type = "SystemAssigned"
  }

  site_config {}
}
