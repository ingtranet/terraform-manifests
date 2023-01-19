resource "vultr_ssh_key" "default" {
  name = "default"
  ssh_key = var.ssh_public_key
}