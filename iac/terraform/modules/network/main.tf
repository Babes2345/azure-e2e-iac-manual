resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_platform_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.rg_platform_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_platform_name
  tags                = var.tags
}

# Allow HTTPS inbound (example baseline)
resource "azurerm_network_security_rule" "allow_https_inbound" {
  name                        = "Allow-HTTPS-Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_platform_name
  network_security_group_name = azurerm_network_security_group.app_nsg.name
}

# Deny all inbound (explicit baseline)
resource "azurerm_network_security_rule" "deny_all_inbound" {
  name                        = "Deny-All-Inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_platform_name
  network_security_group_name = azurerm_network_security_group.app_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_assoc" {
  subnet_id                 = azurerm_subnet.subnet["snet-app"].id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}
