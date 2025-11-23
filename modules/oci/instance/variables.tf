variable "compartment_id" {
  description = "OCID for the Instance Compartment."
  type        = string
}

variable "subnet_id" {
  description = "OCID of the instance's subnet."
  type        = string
}

variable "instance_name" {
  description = "Name of the Instance."
  type        = string
}

variable "ssh_public_key" {
  description = "Trusted SSH key for instance connection."
  type        = string
}

variable "image_id" {
  description = "Image base for the instance."
  type        = string
}

variable "availability_domain" {
  description = "Availability Domain for the instance."
  type        = string
}
