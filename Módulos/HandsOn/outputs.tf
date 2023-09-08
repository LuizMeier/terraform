output "stack_lb_ip" {
  value = module.do-wp_stack.lb_ip
  description = "IP do LB"
}

output "stack_wp_db_user" {
  value     = module.do-wp_stack.wp_db_user
  description = "Usuário do MySQL"
}

output "stack_wp_db_password" {
  value     = module.do-wp_stack.wp_db_password
  description = "Senha do MySQL"
  sensitive = true
}

output "stack_wp_vm_ips" {
  value     = module.do-wp_stack.wp_vm_ips
  description = "IP das máquinas virtuais"
}

output "stack_nfs_vm_ips" {
  value     = module.do-wp_stack.nfs_vm_ips
  description = "IP do NFS"
}