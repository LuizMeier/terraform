#resource "local_file" "arquivo" {
#  content  = var.conteudo
#  filename = "arquivo-${terraform.workspace}.txt"
#}
#
#variable "conteudo" {
#  type        = string
#  description = "Conteúdo do arquivo"
#}

#variable "nome_arquivo" {
#  type        = string
#  description = "Conteúdo do arquivo"
#}

terraform {
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

resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "${var.k8s_name}-${terraform.workspace}"
  region  = var.k8s_region
  version = var.k8s_version

  node_pool {
    name       = var.k8s_node_pool_name
    size       = var.k8s_node_size
    node_count = var.k8s_node_count
  }
  #  lifecycle {
  #    prevent_destroy = true
  #  }
}

variable "do_token" {
  type = string
}

variable "k8s_region" {
  type    = string
  default = "nyc1"
}

variable "k8s_name" {
  type    = string
  default = "k8s-1-27-4-do-0-nyc1-1694377503795"
}

variable "k8s_version" {
  type    = string
  default = "1.27.4-do.0"
}

variable "k8s_node_size" {
  type    = string
  default = "s-1vcpu-2gb"
}

variable "k8s_node_count" {
  type    = number
  default = 1
}

variable "k8s_node_pool_name" {
  type    = string
  default = "pool-teste"
}