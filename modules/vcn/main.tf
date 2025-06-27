resource "oci_core_virtual_network" "this" {
  cidr_block     = var.cidr_block
  display_name   = var.display_name
  compartment_id = var.compartment_id
}
