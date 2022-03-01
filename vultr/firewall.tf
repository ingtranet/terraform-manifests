resource "vultr_firewall_group" "default_firewall" {
    description = "default_firewall"
}

resource "vultr_firewall_group" "for_gateway" {
    description = "firewall for gateway"
}

resource "vultr_firewall_rule" "my_firewallrule" {
    firewall_group_id = vultr_firewall_group.for_gateway.id
    protocol = "udp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "49217"
    notes = "For Wireguard"
}

resource "vultr_firewall_group" "for_k8s" {
    description = "firewall for k8s"
}
