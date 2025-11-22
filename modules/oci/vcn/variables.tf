variable "compartment_id" {
  description = "OCI Compartment ID for the VCN."
  type        = string
}

variable "vcn_name" {
  description = "Name of the VCN."
  type        = string
}

variable "vcn_cidr" {
  description = "IPv4 CIDR of the VCN."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR of the Public Subnet."
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "IPv4 CIDR of the Private Subnet."
  type        = string
  default     = "10.0.1.0/24"
}
