#--------------------------#
# Preferred Instance Image #
#--------------------------#
data "oci_core_images" "ubuntu" {
  compartment_id           = local.tenancy_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
  state                    = "AVAILABLE"
  filter {
    name = "display_name"
    values = ["Canonical-Ubuntu-24.04-aarch64.*"]
    regex = true
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = local.tenancy_ocid
}
