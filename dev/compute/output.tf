output "connection_strings" {
  value = {
    for k, v in oci_core_instance.test_instance :
    v.display_name => "ssh ubuntu@${v.public_ip}"
  }
}
