resource "linode_instance" "instance" {
  label            = var.linode_label != "" ? var.linode_label : null
  image            = var.linode_image
  stackscript_id   = var.linode_stackscript_id != "" ? var.linode_stackscript_id : null
  region           = var.linode_region
  type             = var.linode_type
  authorized_users = ["${var.linode_authorized_users}"]
  # firewall_id      = var.linode_firewall_id != "" ? var.linode_firewall_id : null //Reference existing firewall ID
  firewall_id = linode_firewall.firewall.id //Create unique firewall ID in Terraform
}

output "instance_ip" {
  value = linode_instance.instance.ip_address
}

resource "linode_firewall" "firewall" {
  count = var.linode_firewall_ports != "" ? 1 : 0
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

resource "cloudflare_dns_record" "dns_record" {
  count   = var.linode_label != "" ? 1 : 0
  zone_id = var.cloudflare_zone_id
  name    = linode_label
  value   = linode_instance.instance.ip_address
  type    = "A"
  ttl     = 60
}