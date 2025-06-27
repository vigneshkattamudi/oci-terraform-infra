resource "oci_core_instance" "bastion" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "bastion-instance"
  shape               = "VM.Standard.E5.Flex"
  shape_config {
    ocpus = 1
    memory_in_gbs = 6
  }

  source_details {
    source_type = "image"
    source_id = "ocid1.image.oc1.uk-london-1.aaaaaaaa3rygccfubatxnmx2ccg66wty5drzo4vux3bvkkjoy2guc5xssaqa"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}