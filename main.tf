terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 3.0.2-rc05"
    }
  }
}

provider "proxmox" {
  # you can also set these via environment variables:
  #   PM_API_URL, PM_API_TOKEN_ID, PM_API_TOKEN_SECRET, PM_TLS_INSECURE
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = var.pm_tls_insecure
}

# Create one VM per element in var.vms
resource "proxmox_vm_qemu" "vm" {
  # each.name must be unique
  for_each = { for vm in var.vms : vm.name => vm }

  name        = each.value.name
  target_node = each.value.node
  tags        = join(",", each.value.tags)

  # Clone from your existing Ubuntu cloud-init template
  clone      = var.template_name
  full_clone = true
  os_type    = "cloud-init"

  # CPU + RAM
  cpu {
    sockets = 1
    cores   = each.value.cores
    type    = "host"
  }

  memory = each.value.memory_mb

  # Basic virtio network on given bridge
  network {
    id     = 0         # required by recent provider versions :contentReference[oaicite:1]{index=1}
    model  = "virtio"
    bridge = var.bridge
  }

  # Cloud-init: user + ssh + IP
  ciuser  = var.ci_user
  sshkeys = var.ssh_public_key

  # If you use DHCP, just set "ip=dhcp"
  ipconfig0 = each.value.ip_cidr == "dhcp"
    ? "ip=dhcp"
    : "ip=${each.value.ip_cidr},gw=${each.value.gateway}"

  # Optional DNS server
  nameserver = var.nameserver

  # Let Terraform ensure a cloud-init CD-ROM exists
  # (backed by the given storage)
  cloudinit_cdrom_storage = var.cloudinit_storage

  onboot = true
}
