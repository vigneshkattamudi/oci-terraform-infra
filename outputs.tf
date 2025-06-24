output "instance_public_ip" {
  value = oci_core_instance.vm.public_ip
}

output "instance_id" {
  value = oci_core_instance.vm.id
}

output "vcn_id" {
  value = oci_core_virtual_network.vcn.id
}
