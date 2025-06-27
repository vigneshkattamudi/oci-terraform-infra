resource "oci_core_subnet" "this" {
  cidr_block                 = var.cidr_block
  display_name               = var.display_name
  vcn_id                     = var.vcn_id
  compartment_id             = var.compartment_id
  availability_domain        = var.availability_domain
  route_table_id             = var.route_table_id
  security_list_ids          = var.security_list_ids
  prohibit_public_ip_on_vnic = true
}
