locals {
  resource_location_name = replace(lower(var.environment_type_name), " ", "")
  dns_zone_resource_name = lower(var.environment_type_name) == "prd" ? "madsogsender210625.dk" : "${var.environment_type_name}.madsogsender210625.dk"
}
