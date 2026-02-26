variable "location" {
  type        = string
  description = "Azure region for all resources."

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must be a non-empty Azure region, e.g. 'centralus'."
  }
}

variable "tags" {
  type        = map(string)
  description = "Standard tags applied to all resources."
  default     = {}
}



variable "rg_platform_name" { type = string }
variable "rg_workload_name" { type = string }
variable "log_analytics_name" { type = string }
variable "app_insights_name" { type = string }

variable "vnet_name" { type = string }
variable "vnet_address_space" { type = list(string) }

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "nsg_name" { type = string }

variable "key_vault_name" { type = string }
variable "create_demo_secret" { type = bool }
variable "demo_secret_value" {
  type      = string
  sensitive = true
}

variable "app_service_plan_name" { type = string }
variable "web_app_name" { type = string }
variable "slot_name" { type = string }

variable "kv_consumers_group_object_id" {
  type        = string
  description = "Object ID of AAD group granted Key Vault Secrets User."
}

variable "enable_appservice" {
  type        = bool
  description = "Deploy App Service resources."
  default     = false
}

variable "alert_email" {
  type        = string
  description = "Email to receive alert notifications."
}
