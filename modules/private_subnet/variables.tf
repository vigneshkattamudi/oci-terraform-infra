variable "cidr_block" {
  type = string
}

variable "display_name" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "route_table_id" {
  type = string
}

variable "security_list_ids" {
  type = list(string)
}