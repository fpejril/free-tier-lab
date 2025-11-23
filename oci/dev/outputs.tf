output "connection_strings" {
  description = "Connection Strings for connecting to the instances."
  value = {
    for k, v in module.instance :
    v.instance_name => "ssh ubuntu@${v.public_ip}"
  }
}
