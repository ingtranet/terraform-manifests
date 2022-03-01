resource "linode_instance" "gateway" {
    label = "gateway"
    image = "linode/ubuntu20.04"
    region = "ap-northeast"
    type = "g6-nanode-1"
    authorized_keys = [trimspace(file("~/.ssh/id_rsa.pub"))]
    root_pass = var.linode_instance_password

    swap_size = 0
    private_ip = true
}