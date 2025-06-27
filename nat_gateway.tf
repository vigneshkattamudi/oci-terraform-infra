resource "oci_core_nat_gateway" "nat" {
  compartment_id = var.compartment_ocid
  display_name   = "nat-gateway-demo"
  vcn_id         = oci_core_virtual_network.vcn.id
}

resource "oci_core_route_table" "private_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "private-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat.id
  }
}