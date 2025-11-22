locals {
  vcn_safe_name        = replace(var.vcn_name, "/[^0-9A-Za-z]/", "")
  vcn_dns_label        = substr(local.vcn_safe_name, 0, 15)
  public_sn_dns_label  = substr("snpubl${local.vcn_dns_label}", 0, 15)
  private_sn_dns_label = substr("snpriv${local.vcn_dns_label}", 0, 15)
}
