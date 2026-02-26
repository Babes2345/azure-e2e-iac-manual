resource "azurerm_resource_group" "platform" {
  name     = var.rg_platform_name
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [location]
  }
}

resource "azurerm_resource_group" "workload" {
  name     = var.rg_workload_name
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [location]
  }
}

