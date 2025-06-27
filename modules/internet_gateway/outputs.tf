output "internet_gateway_id" {
  value = oci_core_internet_gateway.this.id
}

output "route_table_id" {
  value = oci_core_route_table.public_rt.id
}