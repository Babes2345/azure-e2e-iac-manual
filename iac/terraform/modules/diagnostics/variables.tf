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
