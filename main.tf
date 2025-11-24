
---

## `main.tf`

```hcl
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 3.0"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  # Turn off if you have proper TLS
  pm_tls_insecure = var.proxmox_tls_insecure

  pm_log_enable = false
}

locals {
  vms = var.vms
}

module "vm" {
  source = "./modules/cloudinit-vm"

  for_each = local.vms

  name   = each.key
  node   = each.value.node

  template = var.vm_template

  cores     = each.value.cores
  memory_mb = each.value.memory_mb
  disk_gb   = each.value.disk_gb

  disk_storage = var.disk_storage
  bridge       = var.network_bridge

  ip_address          = each.value.ip_address
  network_cidr_suffix = var.network_cidr_suffix
  gateway             = var.network_gateway

  ssh_user        = var.ssh_user
  ssh_public_key  = var.ssh_public_key

  cloudinit_cdrom_storage = var.cloudinit_cdrom_storage

  # Optional: if you have a custom cloud-init snippet in Proxmox, e.g.
  #   /var/lib/vz/snippets/ci-custom.yml on storage "local"
  # you’d set cicustom to "vendor=local:snippets/ci-custom.yml"
  cicustom = var.cicustom
}
