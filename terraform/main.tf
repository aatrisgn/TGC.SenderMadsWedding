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

resource "azurerm_dns_zone" "dev-dns-zone" {
  name                = local.dns_zone_resource_name
  resource_group_name = data.azurerm_resource_group.predefined_resource_group.name
}

resource "azurerm_dns_ns_record" "dev_childzone_record" {
  count               = var.environment_type_name == "prd" ? 1 : 0
  name                = "dev"
  zone_name           = azurerm_dns_zone.dev-dns-zone.name
  resource_group_name = data.azurerm_resource_group.predefined_resource_group.name
  ttl                 = 300

  records = data.azurerm_dns_ns_record.dev_dns_zone.records
}
