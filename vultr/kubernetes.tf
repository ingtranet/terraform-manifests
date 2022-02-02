resource "vultr_kubernetes" "tokyo" {
  region  = "nrt"
  label   = "ingtranet-vultr-tokyo"
  version = "v1.22.6+1"

  node_pools {
    node_quantity = 2
    plan          = "vc2-2c-4gb"
    label         = "main"
  }
} 