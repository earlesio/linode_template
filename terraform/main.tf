resource "linode_instance" "instance" {
  label            = var.linode_label != "" ? var.linode_label : null
  image            = var.linode_image
  stackscript_id   = var.linode_stackscript_id != "" ? var.linode_stackscript_id : null
  region           = var.linode_region
  type             = var.linode_type
  authorized_users = ["${var.linode_authorized_users}"]
  firewall_id      = var.linode_firewall_id != "" ? var.linode_firewall_id : linode_firewall.firewall[0].id //Reference existing firewall ID
  # firewall_id = var.linode_id == "" ? linode_firewall.firewall[0].id : null //Create unique firewall ID in Terraform
}

output "instance_ip" {
  value = linode_instance.instance.ip_address
}

resource "linode_firewall" "firewall" {
  count = var.linode_firewall_id == "" ? 1 : 0
  label = "${var.linode_label}_firewall"
  inbound {
    label    = "inbound-tcp"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = var.linode_firewall_ports
    ipv4     = var.linode_firewall_source_ip
  }

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"
}

resource "cloudflare_record" "dns_record" { //This will be replaced by "cloudflare_dns_record in 5.0 provider"
  count   = var.linode_label != "" ? 1 : 0
  zone_id = var.cloudflare_zone_id
  name    = var.linode_label
  # value   = linode_instance.instance.ip_address
  content = linode_instance.instance.ip_address //This will be replaced by "value" in 5.0 provider"
  type    = "A"
  ttl     = 60
}