# BIG-IP Management Public IP Addresses
output "bigip_mgmt_ips" {
  value = {
    external_az1 = module.external_az1.mgmt_public_ips
    external_az2 = module.external_az2.mgmt_public_ips
    ips      = module.ips.mgmt_public_ips
    internal = module.internal.mgmt_public_ips
  }
}

# BIG-IP Management Public DNS Address
output "bigip_mgmt_dns" {
  value = {
    external_az1 = module.external_az1.mgmt_public_dns
    external_az2 = module.external_az2.mgmt_public_dns
    ips      = module.ips.mgmt_public_dns
    internal = module.internal.mgmt_public_dns
  }
}

# BIG-IP Management Port
output "bigip_mgmt_port" {
  value = {
    external_az1 = module.external_az1.mgmt_port
    external_az2 = module.external_az2.mgmt_port
    ips      = module.ips.mgmt_port
    internal = module.internal.mgmt_port
  }
}

output "mgmt_addresses" {
  description = "List of BIG-IP management addresses"
  value = {
    external_az1 = module.external_az1.mgmt_addresses
    external_az2 = module.external_az2.mgmt_addresses
    ips      = module.ips.mgmt_addresses
    internal = module.internal.mgmt_addresses
  }
}

output "public_addresses" {
  description = "List of BIG-IP public addresses"
  value = {
    external_az1 = module.external_az1.public_addresses
    external_az2 = module.external_az2.public_addresses
    ips      = module.ips.public_addresses
    internal = module.internal.public_addresses
  }
}

output "private_addresses" {
  description = "List of BIG-IP private addresses"
  value = {
    external_az1 = module.external_az1.private_addresses
    external_az2 = module.external_az2.private_addresses
    ips      = module.ips.private_addresses
    internal = module.internal.private_addresses
  }
}

# Public Network Interface
output "public_nic_ids" {
  description = "List of BIG-IP public network interface ids"
  value = {
    external_az1 = module.external_az1.public_nic_ids
    external_az2 = module.external_az2.public_nic_ids
    ips      = module.ips.public_nic_ids
    internal = module.internal.public_nic_ids
  }
}

# BIG-IP map
output "bigip_map" {
  description = "Map of the deployed BIG-IPs and their network information"
  value = {
    external_az1 = module.external_az1.bigip_map
    external_az2 = module.external_az2.bigip_map
    ips      = module.ips.bigip_map
    internal = module.internal.bigip_map
  }
}
