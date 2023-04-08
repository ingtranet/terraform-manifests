resource "vultr_firewall_group" "default" {
    description = "default firewall"
}

resource "vultr_firewall_group" "gateway" {
    description = "firewall for gateway"
}

resource "vultr_firewall_rule" "allow_http" {
    firewall_group_id = vultr_firewall_group.gateway.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "80"
    notes = "allow http"
}

resource "vultr_firewall_rule" "allow_https" {
    firewall_group_id = vultr_firewall_group.gateway.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "443"
    notes = "allow https"
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
