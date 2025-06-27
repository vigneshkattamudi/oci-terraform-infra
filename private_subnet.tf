# private_subnet.tf
resource "oci_core_subnet" "private_subnet" {
  cidr_block                 = "10.0.2.0/24"
  display_name               = "private-subnet-demo"
  vcn_id                     = oci_core_virtual_network.vcn.id
  compartment_id             = var.compartment_ocid
  availability_domain        = var.availability_domain
  route_table_id             = oci_core_route_table.private_rt.id
  security_list_ids          = [oci_core_security_list.sec_list.id]
  prohibit_public_ip_on_vnic = true
}