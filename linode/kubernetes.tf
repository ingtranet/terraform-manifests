resource "linode_lke_cluster" "ingtranet_linode_tokyo" {
    label       = "ingtranet-linode-tokyo"
    k8s_version = "1.22"
    region      = "ap-northeast"

    pool {
        type  = "g6-standard-2"
        count = 2
    }
}