locals {
  naming_convention_info = {
    site = "dev"
    env     = "test"
    app     = "test"
    name    = "test"
  }

    tags = {
        environment = "dev"
        project     = "test"
    }

}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = {
      }
    }
  }
}

module "azurerm_private_dns_zone" {
  source              = "git::https://github.com/BrettOJ/tf-az-module-azure-private-dns-zone?ref=main"
  name                = var.private_dns_zone_name
  resource_group_name = module.resource_groups.rg_output[1].name
  tags                = var.tags
  domain_name         = var.domain_name
  dns_a_record = {
    1 = {
      name                = "www"
      zone_name           = var.domain_name
      resource_group_name = module.resource_groups.rg_output.1.name
      ttl                 = 300
      records             = ["10.1.1.0"]
    }
  }
}

module "azurerm_private_dns_zone_virtual_network_link" {
  source                = "git::https://github.com/BrettOJ/tf-az-module-private-dns-vnet-link?ref=main"
  resource_group_name   = module.resource_groups.rg_output[1].name
  private_dns_zone_name = module.azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = module.azurerm_virtual_network.vnet_id
  registration_enabled  = var.registration_enabled
  naming_convention_info = local.naming_convention_info
  tags                  = local.tags
}

module "azurerm_virtual_network" {
  source              = "git::https://github.com/BrettOJ/tf-az-module-virtual-network?ref=main"
  name                = "test-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = module.resource_groups.rg_output[1].name
    naming_convention_info = local.naming_convention_info
    tags                  = local.tags
}