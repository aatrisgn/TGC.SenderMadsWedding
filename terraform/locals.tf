locals {
    resource_location_name = replace(lower(var.environment_type_name), " ", "")
}