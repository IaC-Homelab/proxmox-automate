# https://192.168.1.30:8006/api2/json
variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API URL, e.g. https://pve1:8006/api2/json"
}

# root@pam!ansible
variable "proxmox_api_token_id" {
  type        = string
  description = "Proxmox API token ID, e.g. terraform@pam!token-name"
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "Proxmox API token secret"
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  type        = bool
  description = "Allow insecure TLS (self-signed certs)"
  default     = true
}

variable "vm_template" {
  type        = string
  description = "Name of the Proxmox cloud-init template to clone from"
}

variable "disk_storage" {
  type        = string
  description = "Proxmox storage name for VM disks"
  default     = "local-lvm"
}

variable "cloudinit_cdrom_storage" {
  type        = string
  description = "Storage to use for the cloud-init CD-ROM"
  default     = "local-lvm"
}

variable "network_bridge" {
  type        = string
  description = "Default bridge to attach VMs to"
  default     = "vmbr0"
}

variable "network_cidr_suffix" {
  type        = number
  description = "CIDR suffix for network, e.g. 24"
  default     = 24
}

variable "network_gateway" {
  type        = string
  description = "Default gateway IP address"
}

variable "ssh_user" {
  type        = string
  description = "Default SSH / cloud-init user"
  default     = "ubuntu"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key injected via cloud-init"
}

variable "cicustom" {
  type        = string
  description = "Optional cicustom string for extra cloud-init (e.g. vendor=local:snippets/ci-custom.yml)"
  default     = null
}

variable "vms" {
  description = "Map of VMs to create"
  type = map(object({
    node        = string
    cores       = number
    memory_mb   = number
    disk_gb     = number
    ip_address  = string
  }))
}
