output "instance_id" {
  value       = oci_core_instance.this.id
  description = "OCID of the instance."
}

output "instance_name" {
  value       = oci_core_instance.this.display_name
  description = "Name of the instance."
}

output "public_ip" {
  value       = oci_core_instance.this.public_ip
  description = "Public IP of the instance."
}
