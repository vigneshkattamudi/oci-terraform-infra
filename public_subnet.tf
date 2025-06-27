resource "oci_core_subnet" "public_subnet" {
  cidr_block                 = "10.0.1.0/24"
  display_name               = "public-subnet-demo"
  vcn_id                     = oci_core_virtual_network.vcn.id
  compartment_id             = var.compartment_ocid
  availability_domain        = var.availability_domain
  route_table_id             = oci_core_route_table.rt.id
  security_list_ids          = [oci_core_security_list.sec_list.id]
  prohibit_public_ip_on_vnic = false
}