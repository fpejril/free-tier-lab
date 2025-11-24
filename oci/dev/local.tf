locals {
  environment     = "dev"
  vcn_cidr        = "10.42.0.0/16"
  public_sn_cidr  = "10.42.0.0/24"
  private_sn_cidr = "10.42.1.0/24"
  tenancy_ocid    = "ocid1.tenancy.oc1..aaaaaaaar2baaildkhge35qjg5vavyqc3oebn3miul5jfu6uyt5lqpjifoga"
  ssh_public_key  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUDf4vz+6QMNIVliVFE/V3qfssk5b14HDhA3oYgJeN+"

  ad_names        = data.oci_identity_availability_domains.ads.availability_domains[*].name
  instance_prefix = "instance-${local.environment}"
  vcn_name        = "vcn-${local.environment}"
}
