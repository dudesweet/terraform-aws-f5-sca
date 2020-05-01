variable "aws_region" {
  description = "AWS Region to deploy SCA in"
  type        = string
}

variable "project" {
  description = "Project name for the SCA deployment"
  type        = string
}

variable "vpcs" {
  description = "map of VPCs to create"
  type = map(object({
    cidr_block             = string
    num_availability_zones = number
    internet_gateway       = bool
    nat_gateway            = bool
  }))
  default = {
    "security" : {
      cidr_block : "10.100.0.0/16"
      num_availability_zones : 2
      internet_gateway : true
      nat_gateway : true
    }
    "application" : {
      cidr_block : "10.200.0.0/16"
      num_availability_zones : 2
      internet_gateway : false
      nat_gateway : false
    }
    "container" : {
      cidr_block : "10.240.0.0/16"
      num_availability_zones : 2
      internet_gateway : false
      nat_gateway : false
    }
  }
}

variable "subnets" {
  description = "map of subnets to create for each VPC"
  type = map(object({
    vpc                     = string
    netnum                  = number
    map_public_ip_on_launch = string
  }))
  default = {
    "internet" : {
      vpc : "security"
      netnum : 0
      map_public_ip_on_launch : true
    }
    "mgmt" : {
      vpc : "security"
      netnum : 2
      map_public_ip_on_launch : false
    }
    "dmz_outside" : {
      vpc : "security"
      netnum : 4
      map_public_ip_on_launch : false
    }
    "dmz_inside" : {
      vpc : "security"
      netnum : 6
      map_public_ip_on_launch : false
    }
    "internal" : {
      vpc : "security"
      netnum : 8
      map_public_ip_on_launch : false
    }
    "application" : {
      vpc : "security"
      netnum : 10
      map_public_ip_on_launch : false
    }
    "egress_to_ch1" : {
      vpc : "security"
      netnum : 12
      map_public_ip_on_launch : false
    }
    "ingress_frm_ch1" : {
      vpc : "security"
      netnum : 14
      map_public_ip_on_launch : false
    }
    "egress_to_ch2" : {
      vpc : "security"
      netnum : 16
      map_public_ip_on_launch : false
    }
    "ingress_frm_ch2" : {
      vpc : "security"
      netnum : 18
      map_public_ip_on_launch : false
    }
    "peering" : {
      vpc : "security"
      netnum : 20
      map_public_ip_on_launch : false
    }
  }
}

variable "routes" {
  description = "map of route tables to create for each VPC"
  type = map(object({
    vpc     = string
    subnets = list(string)
  }))
  default = {
    "iwg" : {
      vpc : "security"
      subnets : ["mgmt", "internet"]
    }
    "internal" : {
      vpc : "security"
      subnets : ["internal", "peering"]
    }
    "application" : {
      vpc : "security"
      subnets : ["application"]
    }
    "to_security_insepction_1" : {
      vpc : "security"
      subnets : ["egress_to_ch1", "dmz_outside"]
    }
    "frm_security_insepction_1" : {
      vpc : "security"
      subnets : ["ingress_frm_ch1", "dmz_inside"]
    }
    "to_security_insepction_2" : {
      vpc : "security"
      subnets : ["egress_to_ch2"]
    }
    "frm_security_insepction_2" : {
      vpc : "security"
      subnets : ["ingress_frm_ch2"]
    }
  }
}

variable "nat_gateways" {
  description = "map of route tables to create for each VPC"
  type = map(object({
    vpc     = string
    subnets = list(string)
  }))
  default = {
    "internet" : {
      vpc : "security"
      subnets : ["internet"]
    }
  }
}

variable "tags" {
  description = "map of tags to include in resource creation"
  type        = map(string)
  default     = {}
}

variable "allowed_mgmt_cidr" {
  description = "CIDR of allowed IPs for the BIG-IP management interface"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_app_cidr" {
  description = "CIDR of allowed IPs for the BIG-IP Virtual Servers"
  type        = string
  default     = "0.0.0.0/0"
}
