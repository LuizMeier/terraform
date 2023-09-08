output "lb_ip" {
  value = digitalocean_loadbalancer.wp_lb.ip
  description = "IP do LB"
}

output "wp_db_user" {
  value     = digitalocean_database_user.wp_database_user.name
  description = "Usuário do MySQL"
}

output "wp_db_password" {
  value     = digitalocean_database_user.wp_database_user.password
  description = "Senha do MySQL"
  sensitive = true
}

output "wp_vm_ips" {
  value     = digitalocean_droplet.vm_wp[*].ipv4_address
  description = "IP das máquinas virtuais"
}

output "nfs_vm_ips" {
  value     = digitalocean_droplet.vm_nfs.ipv4_address
  description = "Senha do MySQL"
}