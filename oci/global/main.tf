resource "oci_objectstorage_bucket" "tf_states" {
  name           = "tf-states"
  compartment_id = local.tenancy_ocid
  namespace      = local.tenancy_object_storage_namespace
  versioning     = "Enabled"
}

# TODO: Import identity resources like compartments, dynamic groups, etc.