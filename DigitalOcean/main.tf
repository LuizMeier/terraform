terraform {
  required_version = "~> 1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "vm_aula" {
  image    = "ubuntu-22-04-x64"
  name     = "${var.droplet_name}-${count.index}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.ssh_key.id]
  count    = var.vms_count

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.ssh_private_key)
    host        = digitalocean_droplet.vm_aula[0].ipv4_address
  }

  provisioner "file" {
    source      = "arquivo-instalacao.sh"
    destination = "/root/arquivo-instalacao.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /root/arquivo-instalacao.sh",
      "/root/arquivo-instalacao.sh"
    ]
  }
}

# Create a new SSH key
resource "digitalocean_ssh_key" "ssh_key" {
  name       = "WSL Terraform"
  public_key = file("~/.ssh/terraform.pub")
}

resource "digitalocean_firewall" "firewall_aula" {
  name = "only-22-80-and-443"

  droplet_ids = digitalocean_droplet.vm_aula[*].id

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

