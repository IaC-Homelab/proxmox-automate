output "vm_ips" {
  description = "IPs of all created VMs"
  value = {
    for name, vm in module.vm :
    name => vm.ip_address
  }
}

output "vm_nodes" {
  description = "Which node each VM landed on"
  value = {
    for name, vm in module.vm :
    name => vm.node
  }
}
