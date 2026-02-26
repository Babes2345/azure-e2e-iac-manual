variable "location" {
  type = string
}

variable "rg_platform_name" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "alert_email" {
  type = string
}

variable "action_group_name" {
  type = string
}

variable "kv_alert_name" {
  type = string
}
