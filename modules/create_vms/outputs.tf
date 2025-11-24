output "ssh_commands" {
  description = "SSH command per VM"
  value = {
    for name, cfg in var.vms :
    name => "ssh ${var.ci_username}@${split("/", cfg.ip_cidr)[0]}"
  }
}

