variable "private_dns_zone_name" {
  description = "The name of the Private DNS zone (without a terminating dot)."
}

variable "location" {
  description = "The location/region where the resource group should be created."
}

variable "resource_group_name" {
  description = "Specifies the resource group where the Private DNS Zone exists."
}

variable "virtual_network_id" {
  description = "The ID of the Virtual Network that should be linked to the DNS Zone."
}

variable "registration_enabled" {
  description = "Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?"
  default     = false
}

