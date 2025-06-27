output "instance_public_ip" {
  value = oci_core_instance.this.public_ip
}

output "instance_private_ip" {
  value = oci_core_instance.this.private_ip
}

output "instance_id" {
  value = oci_core_instance.this.id
}

output "availability_domain" {
  value = oci_core_instance.this.availability_domain
}
