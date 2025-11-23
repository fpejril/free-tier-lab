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
  backend "oci" {
    bucket    = "tf-states"
    namespace = "axyllwfaj136"
    key       = "global.tfstate"
  }
}

provider "oci" {}
