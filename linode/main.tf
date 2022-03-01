terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.25.2"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = var.linode_api_key
}
