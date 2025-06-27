output "private_instance_public_ip" {
  value = module.private_instance.instance_public_ip
}

output "private_instance_private_ip" {
  value = module.private_instance.instance_private_ip
}

output "private_instance_id" {
  value = module.private_instance.instance_id
}

output "private_instance_availability_domain" {
  value = module.private_instance.availability_domain
}

output "public_subnet_id" {
  value = module.public_subnet.subnet_id
}
