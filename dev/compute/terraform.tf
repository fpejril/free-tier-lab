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
}