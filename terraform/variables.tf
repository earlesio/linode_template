# GITHUB ORG LEVEL VARIABLES
variable "b2_s3_endpoint" {}
variable "b2_application_key_id" {}
variable "b2_application_key" {}
variable "b2_tfstate_bucket" {}
variable "b2_region" {}
variable "linode_token" {}
variable "linode_authorized_users" {}
variable "cloudflare_api_token" {}
variable "cloudflare_zone_id" {}

# GITHUB REPO LEVEL VARIABLES
variable "b2_tfstate_key" {}

# TERRAFORM.TFVARS VARIABLES
variable "linode_region" {}
variable "linode_label" {}
variable "linode_image" {}
variable "linode_type" {}
variable "linode_stackscript_id" {}
variable "linode_firewall_source_ip" {} // A list of IPv4 addresses or networks. Must be in IP/mask (CIDR) format.
variable "linode_firewall_ports" {}     // A string representation of ports and/or port ranges (i.e. "443" or "80-90, 91").
# variable "linode_firewall_id" {} // Alternatively reference an existing firewall ID
