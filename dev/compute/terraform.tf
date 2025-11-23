#-------------------------#
# Terraform Configuration #
#-------------------------#
terraform {
  required_version = ">= 0.12.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 7.0"
    }
  }
  # backend "oci" {
  #   # Required
  #   bucket    = "mybucket"
  #   namespace = "my-namespace"
  #   # Optional
  #   tenancy_ocid         = "ocid1.tenancy.oc1..xxxxxxx"
  #   user_ocid            = "ocid1.user.oc1..xxxxxxxx"
  #   fingerprint          = "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
  #   private_key_path     = "~/.oci/oci_api_key.pem"
  #   region               = "us-ashburn-1"
  #   key                  = "path/to/my/key"
  #   workspace_key_prefix = "envs/"
  #   kms_key_id           = "ocid1.key.oc1.iad.xxxxxxxxxxxxxx"
  #   auth                 = "APIKey"
  #   config_file_profile  = "DEFAULT"
  # }
}

provider "oci" {}
