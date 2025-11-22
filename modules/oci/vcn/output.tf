output "vcn_id" {
  description = "OCID of the VCN."
  value       = oci_core_vcn.this.id
}

output "public_subnet_id" {
  description = "OCID of the Public Subnet."
  value       = oci_core_subnet.public.id
}

output "private_subnet_id" {
  description = "OCID of the Public Subnet."
  value       = oci_core_subnet.private.id
}
