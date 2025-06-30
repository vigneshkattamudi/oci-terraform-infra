variable "compartment_ocid" {}
variable "region" {}
variable "db_name" {}
variable "display_name" {}
variable "admin_password" {
  sensitive = true
}
variable "cpu_core_count" {
  default = 1
}
variable "data_storage_tbs" {
  default = 1
}
variable "auto_scaling" {
  default = true
}
variable "license_model" {
  default = "LICENSE_INCLUDED"
}
variable "ons_topic_id" {}
variable "cpu_alarm_threshold" {
  default = 85
}
variable "freeform_tags" {
  type    = map(string)
  default = {}
}
