variable "droplet_name" {
  default     = "vm-aula"
  type        = string
  description = "Nome da VM"
}

variable "droplet_region" {
  default     = "nyc1"
  type        = string
  description = "Nome da região"
}

variable "droplet_size" {
  default     = "s-1vcpu-512mb-10gb"
  type        = string
  description = "Tamanho da VM"
}

variable "ssh_key_name" {
  default     = "WSL Terraform"
  type        = string
  description = "Nome da chave SSH"
}

variable "ssh_private_key" {
  type        = string
  description = "Nome da chave SSH privada"
}

variable "do_token" {
  type        = string
  description = "Token da API"
}

variable "vms_count" {
  default     = 1
  type        = number
  description = "Quantidade de VMs"
}