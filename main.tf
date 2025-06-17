provider "oci" {
  region = var.region
}

resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "tf-vcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "tf-igw"
  is_enabled     = true
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "tf-rt"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_security_list" "ssh_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "tf-ssh-sl"

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "public_subnet" {
  compartment_id       = var.compartment_ocid
  vcn_id               = oci_core_virtual_network.vcn.id
  cidr_block           = "10.0.1.0/24"
  display_name         = "tf-public-subnet"
  route_table_id       = oci_core_route_table.route_table.id
  security_list_ids    = [oci_core_security_list.ssh_list.id]
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_instance" "vm" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.E2.1.Micro"
  display_name        = "tf-instance"
  subnet_id           = oci_core_subnet.public_subnet.id
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.linux_image.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "linux_image" {
  compartment_id = var.compartment_ocid
  operating_system = "Oracle Linux"
  operating_system_version = "8"
  sort_by = "TIMECREATED"
  sort_order = "DESC"
}
