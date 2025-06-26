# resource "oci_core_virtual_network" "vcn" {
#   cidr_block     = "10.0.0.0/16"
#   display_name   = "vcn-demo"
#   compartment_id = var.compartment_ocid
# }

# resource "oci_core_internet_gateway" "igw" {
#   compartment_id = var.compartment_ocid
#   display_name   = "IGW-demo"
#   vcn_id         = oci_core_virtual_network.vcn.id
# }

# resource "oci_core_route_table" "rt" {
#   compartment_id = var.compartment_ocid
#   vcn_id         = oci_core_virtual_network.vcn.id
#   display_name   = "route-table-demo"
#   route_rules {
#     destination       = "0.0.0.0/0"
#     destination_type  = "CIDR_BLOCK"
#     network_entity_id = oci_core_internet_gateway.igw.id
#   }
# }

# resource "oci_core_security_list" "sec_list" {
#   compartment_id = var.compartment_ocid
#   vcn_id         = oci_core_virtual_network.vcn.id
#   display_name   = "allow-ssh-demo"
#   ingress_security_rules {
#     protocol = "6"
#     source   = "0.0.0.0/0"
#     tcp_options {
#       min = 22
#       max = 22
#     }
#   }
#   egress_security_rules {
#     protocol    = "all"
#     destination = "0.0.0.0/0"
#   }
# }

# resource "oci_core_subnet" "public_subnet" {
#   cidr_block                 = "10.0.1.0/24"
#   display_name               = "public-subnet-demo"
#   vcn_id                     = oci_core_virtual_network.vcn.id
#   compartment_id             = var.compartment_ocid
#   availability_domain        = var.availability_domain
#   route_table_id             = oci_core_route_table.rt.id
#   security_list_ids          = [oci_core_security_list.sec_list.id]
#   prohibit_public_ip_on_vnic = false
# }

# data "oci_objectstorage_namespace" "ns" {}

# resource "oci_objectstorage_bucket" "my_bucket" {
#   compartment_id = var.compartment_ocid
#   name           = "my-terraform-bucket-demo"
#   namespace      = data.oci_objectstorage_namespace.ns.namespace
#   storage_tier   = "Standard"
# }