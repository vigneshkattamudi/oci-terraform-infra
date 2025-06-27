output "nat_gateway_id" {
  value = oci_core_nat_gateway.this.id
}

output "route_table_id" {
  value = oci_core_route_table.private_rt.id
}