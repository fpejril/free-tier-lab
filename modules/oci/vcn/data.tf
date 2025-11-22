data "oci_core_services" "all" {
  filter {
    name   = "name"
    values = ["All ORD Services In Oracle Services Network"]
  }
}