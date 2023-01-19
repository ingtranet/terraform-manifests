variable "os_ids" {
  type = map(number)
  default = {
    "Ubuntu2004" = 387
    "Ubuntu2204" = 1743
    "Rocky9" = 1869
  }
}


resource "vultr_instance" "gateway" {
  plan   = "vc2-1c-1gb"
  region = "icn"
  os_id  = var.os_ids.Rocky9
  hostname = "gateway"
  label = "gateway"
  vpc_ids = [
    vultr_vpc.icn_default.id,
  ]
  ssh_key_ids = [
    vultr_ssh_key.default.id
  ]
  firewall_group_id = vultr_firewall_group.gateway.id
}