resource "proxmox_vm_qemu" "vm" {
  name        = var.name
  target_node = var.node

  clone      = var.template
  full_clone = true

  # Cloud-init template
  os_type                 = "cloud-init"
  cloudinit_cdrom_storage = var.cloudinit_cdrom_storage

  agent  = 1
  cores  = var.cores
  memory = var.memory_mb

  disks {
    scsi {
      scsi0 {
        disk {
          size    = var.disk_gb
          storage = var.disk_storage
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = var.bridge
  }

  # Basic cloud-init config
  ciuser   = var.ssh_user
  sshkeys  = var.ssh_public_key

  ipconfig0 = "ip=${var.ip_address}/${var.network_cidr_suffix},gw=${var.gateway}"

  # Optional extra cloud-init YAML snippet (on Proxmox)
  # e.g. "vendor=local:snippets/ci-custom.yml"
  cicustom = var.cicustom
}
