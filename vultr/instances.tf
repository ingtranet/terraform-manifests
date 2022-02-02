variable "os_ids" {
  type = map(number)
  default = {
    "Ubuntu2004" = 387
  }
}


resource "vultr_instance" "gateway" {
  plan   = "vc2-1c-1gb"
  region = "nrt"
  os_id  = var.os_ids.Ubuntu2004
  hostname = "gateway"
  label = "gateway"
  private_network_ids = [
    data.vultr_private_network.k8s_tokyo.id,
    vultr_private_network.intranet_vultr.id
  ]
  ssh_key_ids = [
    "6c800491-1f42-4313-830f-1b34204a625f"
  ]
}