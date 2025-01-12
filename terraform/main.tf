resource "azurerm_static_web_app" "example" {
  name                = "swa-sendermadswedding-${var.environment_type_name}-${local.resource_location_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = "free"
  sku_size            = "free"
}
