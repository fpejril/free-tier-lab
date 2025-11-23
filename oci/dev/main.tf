module "vcn" {
  source              = "../../modules/oci/vcn"
  compartment_id      = local.tenancy_ocid
  vcn_name            = local.vcn_name
  vcn_cidr            = local.vcn_cidr
  public_subnet_cidr  = local.public_sn_cidr
  private_subnet_cidr = local.private_sn_cidr
}


#-------------------#
# Compute Instances #
#-------------------#
module "instance" {
  source              = "../../modules/oci/instance"
  count               = 4
  availability_domain = local.ad_names[1] # Only us-chicago-2 has available capacity
  ssh_public_key      = local.ssh_public_key
  compartment_id      = local.tenancy_ocid
  instance_name       = "${local.instance_prefix}-${count.index}"
  image_id            = data.oci_core_images.ubuntu.images[0].id
  subnet_id           = module.vcn.public_subnet_id
}
