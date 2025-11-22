locals {
  environment     = "dev"
  vcn_cidr        = "10.2.0.0/16"
  public_sn_cidr  = "10.2.0.0/24"
  private_sn_cidr = "10.2.1.0/24"
  tenancy_ocid    = "ocid1.tenancy.oc1..aaaaaaaar2baaildkhge35qjg5vavyqc3oebn3miul5jfu6uyt5lqpjifoga"
  ssh_public_key = file("~/.ssh/id_ed25519.pub")

  ad_names = data.oci_identity_availability_domains.ads.availability_domains[*].name
  fd_names = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]

  instance_prefix      = "instance-${local.environment}"
  vcn_name             = "vcn-${local.environment}"
  vcn_safe_name        = replace(local.vcn_name, "/[^0-9A-Za-z]/", "")
  vcn_dns_label        = substr(local.vcn_safe_name, 0, 15)
  public_sn_dns_label  = substr("snpubl${local.vcn_dns_label}", 0, 15)
  private_sn_dns_label = substr("snpriv${local.vcn_dns_label}", 0, 15)
}
