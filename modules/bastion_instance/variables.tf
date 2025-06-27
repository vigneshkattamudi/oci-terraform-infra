variable "availability_domain" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "display_name" {
  type = string
}

variable "shape" {
  type    = string
  default = "VM.Standard.E5.Flex"
}

variable "ocpus" {
  type    = number
  default = 1
}

variable "memory_in_gbs" {
  type    = number
  default = 6
}

variable "image_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}