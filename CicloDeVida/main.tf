terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.26.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

variable "do_token" {
  type        = string
  description = "Token da Digital Ocean"
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-22-04-x64"
  name   = "vm-web"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  lifecycle {
    replace_triggered_by = [
        digitalocean_droplet.jenkins
     ]
  }
}

resource "digitalocean_droplet" "jenkins" {
  image  = "ubuntu-22-04-x64"
  name   = "vm-jenkins"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
}