variable "location" { type = string }
variable "tags" { type = map(string) }

variable "rg_platform_name" { type = string }

variable "vnet_name" { type = string }
variable "vnet_address_space" { type = list(string) }

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "nsg_name" { type = string }
