variable "rg_workload_name" {
  type        = string
  description = "Workload resource group name."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "app_service_plan_name" {
  type        = string
  description = "App Service Plan name."
}

variable "web_app_name" {
  type        = string
  description = "Web App name."
}

variable "slot_name" {
  type        = string
  description = "Deployment slot name."
  default     = "staging"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}

variable "app_insights_instrumentation_key" {
  type        = string
  description = "App Insights instrumentation key."
  default     = null
}

variable "app_insights_connection_string" {
  type        = string
  description = "App Insights connection string."
  default     = null
}

variable "enable_slot" {
  type        = bool
  description = "Whether to create a deployment slot (often unsupported on F1)."
  default     = false
}
