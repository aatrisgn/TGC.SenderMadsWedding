terraform {
  backend "azurerm" {
    use_azuread_auth = true
    use_oidc         = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.0.0"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}

resource "azurerm_static_web_app" "primary_static_web_app" {
  name                = "swa-sendermadswedding-${var.environment_type_name}-${local.resource_location_name}"
  resource_group_name = data.azurerm_resource_group.predefined_resource_group.name
  location            = data.azurerm_resource_group.predefined_resource_group.location
  sku_tier            = "Free"
  sku_size            = "Free"
}

resource "azurerm_dns_zone" "dev_dns_zone" {
  name                = local.dns_zone_resource_name
  resource_group_name = data.azurerm_resource_group.predefined_resource_group.name
}

resource "azurerm_role_assignment" "dns_zone_reader" {
  count                = var.environment_type_name == "dev" ? 1 : 0
  scope                = azurerm_dns_zone.dev_dns_zone.id
  role_definition_name = "Reader"
  principal_id         = var.dev_dns_zone_reader_spn_id
}

resource "azurerm_dns_ns_record" "dev_childzone_record" {
  count               = var.environment_type_name == "prd" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.dev-dns-zone.name
  resource_group_name = data.azurerm_resource_group.predefined_resource_group.name
  ttl                 = 300

  records = data.azurerm_dns_ns_record.dev_dns_zone[0].records //Not the prettiest, but easy solution since we will only have 1 DNS zone on this reference ever.
}
