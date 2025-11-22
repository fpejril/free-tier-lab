#-----#
# VCN #
#-----#
resource "oci_core_vcn" "this" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = var.vcn_name
  dns_label      = local.vcn_dns_label
  freeform_tags  = {}
  is_ipv6enabled = false
}

resource "oci_core_nat_gateway" "this" {
  block_traffic  = false
  compartment_id = var.compartment_id
  display_name   = "NAT gateway-${var.vcn_name}"
  freeform_tags  = {}
  vcn_id         = oci_core_vcn.this.id
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_id
  display_name   = "Internet gateway-${var.vcn_name}"
  enabled        = true
  freeform_tags  = {}
  vcn_id         = oci_core_vcn.this.id
}

resource "oci_core_service_gateway" "this" {
  compartment_id = var.compartment_id
  display_name   = "Service gateway-${var.vcn_name}"
  freeform_tags  = {}
  vcn_id         = oci_core_vcn.this.id
  services {
    service_id = data.oci_core_services.all.services[0].id
  }
}

#---------------#
# Public Subnet #
#---------------#
resource "oci_core_security_list" "public" {
  compartment_id = var.compartment_id
  display_name   = "security list for public subnet-${var.vcn_name}"
  freeform_tags  = {}
  vcn_id         = oci_core_vcn.this.id
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = false
  }
  ingress_security_rules {
    protocol    = "1"
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    icmp_options {
      code = -1
      type = 3
    }
  }
  ingress_security_rules {
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    icmp_options {
      code = 4
      type = 3
    }
  }
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    tcp_options {
      max = 22
      min = 22
    }
  }
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_id
  display_name   = "route table for public subnet-${var.vcn_name}"
  freeform_tags  = {}
  vcn_id         = oci_core_vcn.this.id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
    route_type        = "STATIC"
  }
}

resource "oci_core_subnet" "public" {
  cidr_block                 = var.public_subnet_cidr
  compartment_id             = var.compartment_id
  dhcp_options_id            = oci_core_vcn.this.default_dhcp_options_id
  display_name               = "public subnet-${var.vcn_name}"
  dns_label                  = local.public_sn_dns_label
  freeform_tags              = {}
  prohibit_internet_ingress  = false
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.public.id
  security_list_ids          = [oci_core_security_list.public.id]
  vcn_id                     = oci_core_vcn.this.id
}

#----------------#
# Private Subnet #
#----------------#
resource "oci_core_route_table" "private" {
  compartment_id = var.compartment_id
  display_name   = "route table for private subnet-${var.vcn_name}"
  freeform_tags  = {}
  vcn_id         = oci_core_vcn.this.id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.this.id
    route_type        = "STATIC"
  }
  route_rules {
    destination       = data.oci_core_services.all.services[0].cidr_block
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.this.id
    route_type        = "STATIC"
  }
}

resource "oci_core_security_list" "private" {
  compartment_id = var.compartment_id
  display_name   = "security list for private subnet-${var.vcn_name}"
  freeform_tags  = {}
  vcn_id         = oci_core_vcn.this.id
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = false
  }
  ingress_security_rules {
    protocol    = "1"
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    icmp_options {
      code = -1
      type = 3
    }
  }
  ingress_security_rules {
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    icmp_options {
      code = 4
      type = 3
    }
  }
  ingress_security_rules {
    protocol    = "6"
    source      = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    stateless   = false
    tcp_options {
      max = 22
      min = 22
    }
  }
}

resource "oci_core_subnet" "private" {
  cidr_block                 = var.private_subnet_cidr
  compartment_id             = var.compartment_id
  dhcp_options_id            = oci_core_vcn.this.default_dhcp_options_id
  display_name               = "private subnet-${var.vcn_name}"
  dns_label                  = local.private_sn_dns_label
  freeform_tags              = {}
  ipv6cidr_blocks            = []
  prohibit_internet_ingress  = true
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.private.id
  security_list_ids          = [oci_core_security_list.private.id]
  vcn_id                     = oci_core_vcn.this.id
}
