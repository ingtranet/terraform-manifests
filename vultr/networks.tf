data "vultr_private_network" "k8s_tokyo" {
  filter {
    name = "description"
    values = ["VKE_Network_6f1b4492-235a-4e16-9f71-e83f97a08ca1"]
  }
  depends_on = [
    vultr_kubernetes.tokyo
  ]
}

resource "vultr_private_network" "intranet_vultr" {
    description = "intranet_vultr"
    region = "nrt"
    v4_subnet  = "172.24.0.0"
    v4_subnet_mask = 16
}