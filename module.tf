resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = module.vnet_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.registration_enabled
  tags                  = var.tags
}