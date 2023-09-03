terraform {
  required_version = "~> 1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "vm_aula" {
  image    = "ubuntu-22-04-x64"
  name     = var.droplet_name
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
}

data "digitalocean_ssh_key" "ssh_key" {
  name = var.ssh_key_name
}

resource "digitalocean_firewall" "firewall_aula" {
  name = "only-22-80-and-443"

  droplet_ids = [digitalocean_droplet.vm_aula.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["192.168.1.0/24", "2002:1:2::/48"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

variable "droplet_name" {
  default = "vm-aula"
}

variable "droplet_region" {
  default = "nyc1"
}

variable "droplet_size" {
  default = "s-1vcpu-512mb-10gb"
}

variable "ssh_key_name" {
  default = "WSL Terraform"
}

variable "do_token" {
}

output "droplet_ip" {
  value = digitalocean_droplet.vm_aula.ipv4_address
}