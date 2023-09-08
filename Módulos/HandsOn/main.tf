terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~>2.0.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "do-wp_stack" {
  source      = "./modules/do-wp-stack"
  region      = var.region
  wp_vm_count = var.wp_vm_count
  vms_ssh     = digitalocean_ssh_key.ssh.fingerprint
}


resource "digitalocean_ssh_key" "ssh" {
  name       = "wp-ssh"
  public_key = file("~/.ssh/terraform.pub")
}
