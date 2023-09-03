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
  token = ""
}

resource "digitalocean_droplet" "vm_aula" {
  image  = "ubuntu-22-04-x64"
  name   = "vm-aula"
  region = "nyc1"
  size   = "s-1vcpu-512mb-10gb"
}