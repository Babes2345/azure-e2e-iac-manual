module "resourcegroups" {
  source = "../../modules/resourcegroup"

  location         = var.location
  tags             = var.tags
  rg_platform_name = var.rg_platform_name
  rg_workload_name = var.rg_workload_name
}

module "monitoring" {
  source = "../../modules/monitoring"

  location           = var.location
  tags               = var.tags
  rg_platform_name   = var.rg_platform_name
  log_analytics_name = var.log_analytics_name
  app_insights_name  = var.app_insights_name
}

module "network" {
  source = "../../modules/network"

  location         = var.location
  tags             = var.tags
  rg_platform_name = var.rg_platform_name

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space
  subnets            = var.subnets

  nsg_name = var.nsg_name
}

module "keyvault" {
  source = "../../modules/keyvault"

  location         = var.location
  tags             = var.tags
  rg_platform_name = var.rg_platform_name

  key_vault_name     = var.key_vault_name
  create_demo_secret = var.create_demo_secret
  demo_secret_value  = var.demo_secret_value
}

# Optional App Service (disabled by default in dev due to subscription quota constraints)
module "appservice" {
  count  = var.enable_appservice ? 1 : 0
  source = "../../modules/appservice"

  location         = var.location
  tags             = var.tags
  rg_workload_name = var.rg_workload_name

  app_service_plan_name = var.app_service_plan_name
  web_app_name          = var.web_app_name
  slot_name             = var.slot_name
  enable_slot           = false
}

# Key Vault RBAC assignment for "consumer" identity (AAD group object id)
module "rbac" {
  source = "../../modules/rbac"

  key_vault_id = module.keyvault.key_vault_id
  principal_id = var.kv_consumers_group_object_id
}

# Diagnostics: always enable for Key Vault; enable Web App diagnostics only when App Service exists
module "diagnostics" {
  source = "../../modules/diagnostics"

  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  key_vault_id               = module.keyvault.key_vault_id
  web_app_id                 = var.enable_appservice ? module.appservice[0].web_app_id : null
}


variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace resource id."
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault resource id."
}

variable "web_app_id" {
  type        = string
  description = "Web App resource id (optional)."
  default     = null
}

module "alerts" {
  source = "../../modules/alerts"

  location                   = var.location
  rg_platform_name           = var.rg_platform_name
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  tags                       = var.tags

  alert_email       = var.alert_email
  action_group_name = "ag-e2e-dev"
  kv_alert_name     = "alert-kv-failures-dev"
}

