output "ssh_commands" {
  description = "SSH commands for all VMs"
  value       = module.create_vms.ssh_commands
}
