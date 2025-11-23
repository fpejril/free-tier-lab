output "connection_strings" {
  value = {
    for k, v in module.instance :
    v.instance_name => "ssh ubuntu@${v.public_ip}"
  }
}
