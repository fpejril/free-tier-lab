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
resource "oci_core_instance" "test_instance" {
  count = 4
  availability_domain = local.ad_names[1] # Only us-chicago-2 has available capacity
  compartment_id      = local.tenancy_ocid
  display_name        = "${local.instance_prefix}-${count.index}"
  metadata = {
    ssh_authorized_keys = local.ssh_public_key
  }
  shape = "VM.Standard.A1.Flex"
  agent_config {
    are_all_plugins_disabled = false
    is_management_disabled   = false
    is_monitoring_disabled   = false
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Management Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Custom Logs Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Compute RDMA GPU Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Compute HPC RDMA Auto-Configuration"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Compute HPC RDMA Authentication"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Cloud Guard Workload Protection"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Block Volume Management"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }
  availability_config {
    is_live_migration_preferred = false
    recovery_action             = "RESTORE_INSTANCE"
  }
  create_vnic_details {
    assign_private_dns_record = false
    assign_public_ip          = "true"
    skip_source_dest_check    = false
    subnet_id                 = module.vcn.public_subnet_id
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = false
  }
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = true
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  shape_config {
    memory_in_gbs = 6
    ocpus         = 1
    vcpus         = 1
  }
  source_details {
    boot_volume_size_in_gbs         = "50"
    boot_volume_vpus_per_gb         = "10"
    is_preserve_boot_volume_enabled = false
    source_id                       = data.oci_core_images.ubuntu.images[0].id
    source_type                     = "image"
  }
  lifecycle {
    ignore_changes = [source_details[0].source_id]
  }
}
