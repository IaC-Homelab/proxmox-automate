variable "name" {
  type        = string
  description = "VM name"
}

variable "node" {
  type        = string
  description = "Proxmox node name"
}

variable "template" {
  type        = string
  description = "Cloud-init template name to clone from"
}

variable "cores" {
  type        = number
  description = "Number of vCPUs"
}

variable "memory_mb" {
  type        = number
  description = "Memory in MB"
}

variable "disk_gb" {
  type        = number
  description = "Disk size in GB"
}

variable "disk_storage" {
  type        = string
  description = "Proxmox storage name for the disk"
}

variable "bridge" {
  type        = string
  description = "Network bridge name"
}

variable "ip_address" {
  type        = string
  description = "Static IP for the VM"
}

variable "network_cidr_suffix" {
  type        = number
  description = "Network CIDR suffix (e.g. 24)"
}

variable "gateway" {
  type        = string
  description = "Default gateway"
}

variable "ssh_user" {
  type        = string
  description = "Cloud-init user"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for cloud-init"
}

variable "cloudinit_cdrom_storage" {
  type        = string
  description = "Storage for cloud-init CD-ROM"
}

variable "cicustom" {
  type        = string
  description = "Optional cicustom string for extra cloud-init"
  default     = null
}
