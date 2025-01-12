variable "resource_group_name" {
  type = string
}
variable "environment_type_name" {
  type = string
}

variable "dev_dns_zone_resource_name" {
  type     = string
  nullable = true
  default  = null
}

variable "dev_dns_zone_name" {
  type     = string
  nullable = true
  default  = null
}

variable "dev_dns_zone_zone_name" {
  type     = string
  nullable = true
  default  = null
}

variable "dev_dns_zone_reader_spn_id" {
  type     = string
  nullable = true
  default  = null
}
