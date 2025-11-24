#!/usr/bin/env bash
set -euo pipefail

# ----- Config -----
VMID=9000
VMNAME="ubuntu-24.04-cloud"
STORAGE="local-lvm"         # where disks live (e.g. local-lvm, nvme, etc.)
ISO_STORAGE="local"         # where ISO/container images live (for the download)
MEMORY=2048
CORES=2
BRIDGE="vmbr0"
CLOUD_IMG_URL="https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
CLOUD_IMG_NAME="ubuntu-24.04-cloudimg.qcow2"

# ----- Download Ubuntu cloud image -----
IMG_PATH="/var/lib/vz/template/iso/${CLOUD_IMG_NAME}"

if [ ! -f "$IMG_PATH" ]; then
  echo "Downloading Ubuntu cloud image..."
  wget -O "$IMG_PATH" "$CLOUD_IMG_URL"
fi

# ----- Create the VM shell -----
echo "Creating VM ${VMID} (${VMNAME})..."
qm create "$VMID" \
  --name "$VMNAME" \
  --memory "$MEMORY" \
  --cores "$CORES" \
  --net0 "virtio,bridge=${BRIDGE}" \
  --ostype l26

# ----- Import disk into Proxmox storage -----
echo "Importing disk..."
qm importdisk "$VMID" "$IMG_PATH" "$STORAGE" --format qcow2

# Attach imported disk as scsi0
qm set "$VMID" --scsihw virtio-scsi-pci --scsi0 "${STORAGE}:vm-${VMID}-disk-0"

# Boot from the imported disk
qm set "$VMID" --boot c --bootdisk scsi0

# ----- Cloud-init drive -----
qm set "$VMID" --ide2 "${STORAGE}:cloudinit"
qm set "$VMID" --serial0 socket --vga serial0

# Optional: default cloud-init values (you can override per-VM later)
qm set "$VMID" \
  --ciuser admin \
  --cipassword 'Subedi10!' \
  --sshkeys /root/.ssh/id_rsa.pub

# ----- Make VM a template -----
echo "Converting VM ${VMID} to template..."
qm template "$VMID"

echo "Done. Template created: ${VMID} (${VMNAME})"
