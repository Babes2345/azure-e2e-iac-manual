variable "location" { type = string }
variable "tags" { type = map(string) }

variable "rg_platform_name" { type = string }
variable "key_vault_name" { type = string }

variable "create_demo_secret" {
  type    = bool
  default = true
}

variable "demo_secret_value" {
  type      = string
  sensitive = true
  default   = "placeholder-value"
}

