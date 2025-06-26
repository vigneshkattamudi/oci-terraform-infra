resource "oci_core_instance" "test" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "test-instance"
  shape               = "VM.Standard.A1.Flex"

  source_details {
    source_type = "image"
    source_id = "ocid1.image.oc1.uk-london-1.aaaaaaaam5klmkoewhybytfqlkyhcoxyzjxstx6emfk5dop7f2bazqopi5nq"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
