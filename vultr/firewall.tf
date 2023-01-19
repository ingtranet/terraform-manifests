resource "vultr_firewall_group" "default" {
    description = "default firewall"
}

resource "vultr_firewall_group" "gateway" {
    description = "firewall for gateway"
}

resource "vultr_firewall_rule" "gateway_ingress" {
    firewall_group_id = vultr_firewall_group.gateway.id
    protocol = "udp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "52923"
    notes = "for gateway"
}

resource "vultr_firewall_rule" "allow_ssh" {
    firewall_group_id = vultr_firewall_group.gateway.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "22"
    notes = "allow ssh"
}

resource "vultr_firewall_group" "k8s" {
    description = "firewall for k8s"
}
