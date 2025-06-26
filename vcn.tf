resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.0.0.0/16"
  display_name   = "vcn-demo"
  compartment_id = var.compartment_ocid
}