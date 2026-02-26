data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.rg_platform_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  rbac_authorization_enabled = true

  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}

resource "azurerm_key_vault_secret" "demo" {
  count        = var.create_demo_secret ? 1 : 0
  name         = "demo-secret"
  value        = var.demo_secret_value
  key_vault_id = azurerm_key_vault.kv.id
}

