variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "region" {}
variable "compartment_ocid" {}
variable "private_key_path" {}
variable "ssh_public_key" {}
variable "availability_domain" {}
variable "image_id" {}

variable "adb_admin_password" {
  description = "Password for the Autonomous Database admin user"
  type        = string
  sensitive   = true
}

# Add your variable declarations here

variable "ons_topic_id" {
  description = "OCID of the Oracle Notification Service (ONS) topic"
  type        = string
}

variable "cpu_alarm_threshold" {
  description = "CPU % that triggers the alarm"
  type        = number
  default     = 80
}