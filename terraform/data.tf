data "azurerm_resource_group" "predefined_resource_group" {
  name = var.resource_group_name
}

data "azurerm_dns_ns_record" "dev_dns_zone" {
  count               = var.environment_type_name == "prd" ? 1 : 0
  resource_group_name = var.dev_dns_zone_resource_name
  zone_name           = "@"
  name                = var.dev_dns_zone_name
}
