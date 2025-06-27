data "oci_objectstorage_namespace" "ns" {}

resource "oci_objectstorage_bucket" "my_bucket" {
  compartment_id = var.compartment_ocid
  name           = "my-terraform-bucket-demo"
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  storage_tier   = "Standard"
}
