module "vcn" {
  source        = "./modules/vcn"
  cidr_block    = "10.0.0.0/16"
  display_name  = "vcn-demo"
  compartment_id = var.compartment_ocid
}

module "internet_gateway" {
  source                 = "./modules/internet_gateway"
  compartment_id         = var.compartment_ocid
  display_name           = "IGW-demo"
  vcn_id                 = module.vcn.vcn_id
  route_table_display_name = "route-table-demo"
}

module "security_list" {
  source        = "./modules/security_list"
  compartment_id = var.compartment_ocid
  vcn_id        = module.vcn.vcn_id
  display_name  = "allow-ssh-demo"
}

module "public_subnet" {
  source            = "./modules/public_subnet"
  cidr_block        = "10.0.1.0/24"
  display_name      = "public-subnet-demo"
  vcn_id            = module.vcn.vcn_id
  compartment_id    = var.compartment_ocid
  availability_domain = var.availability_domain
  route_table_id    = module.internet_gateway.route_table_id
  security_list_ids = [module.security_list.security_list_id]
}

module "nat_gateway" {
  source                 = "./modules/nat_gateway"
  compartment_id         = var.compartment_ocid
  display_name           = "nat-gateway-demo"
  vcn_id                 = module.vcn.vcn_id
  route_table_display_name = "private-route-table"
}

module "private_subnet" {
  source            = "./modules/private_subnet"
  cidr_block        = "10.0.2.0/24"
  display_name      = "private-subnet-demo"
  vcn_id            = module.vcn.vcn_id
  compartment_id    = var.compartment_ocid
  availability_domain = var.availability_domain
  route_table_id    = module.nat_gateway.route_table_id
  security_list_ids = [module.security_list.security_list_id]
}

module "bastion_instance" {
  source             = "./modules/bastion_instance"
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "bastion-instance"
  shape               = "VM.Standard.E5.Flex"
  ocpus               = 1
  memory_in_gbs       = 6
  image_id            = var.image_id
  subnet_id           = module.public_subnet.subnet_id
  ssh_public_key      = var.ssh_public_key
}

module "private_instance" {
  source             = "./modules/private_instance"
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "private-instance"
  shape               = "VM.Standard.E5.Flex"
  ocpus               = 1
  memory_in_gbs       = 6
  image_id            = var.image_id
  subnet_id           = module.private_subnet.subnet_id
  ssh_public_key      = var.ssh_public_key
}

module "object_storage" {
  source        = "./modules/object_storage"
  compartment_id = var.compartment_ocid
  bucket_name   = "my-terraform-bucket-demo"
}