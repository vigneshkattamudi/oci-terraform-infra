data "oci_objectstorage_namespace" "ns" {}

resource "oci_objectstorage_bucket" "this" {
  compartment_id = var.compartment_id
  name           = var.bucket_name
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  storage_tier   = var.storage_tier
}