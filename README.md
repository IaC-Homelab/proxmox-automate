# proxmox-automate 🛰️
Terraform configs to spin up configured Proxmox VMs with Cloud-Init. Declarative VMs, repeatable builds, no more clicky-clicky in the UI 🖱️❌<br><br>
Uses [`bpg/proxmox`](https://registry.terraform.io/providers/bpg/proxmox/latest) provider. 🧩 <br><br>


## What this repo does ⚙️
- 📥 **Downloads** a **Ubuntu cloud image** to each Proxmox node
- 📄 Creates **Cloud-Init snippets** per node (user, SSH key, packages, etc.)
- 🖥️ Boots VMs with **static IPs**
- 🔑 Prints ready-to-paste SSH commands!
<br><br>

## Layout 🗂️
- `main.tf` – entrypoint, wires the module 🧵
- `modules/create_vms` – all the VM + cloud-init logic 🧠
- `variables.tf` – input variables ⚙️
- `terraform.tfvars` – your environment-specific values 🌎
- `providers.tf` – Terraform + Proxmox provider config 🔌
- `outputs.tf` – outputs like VM IPs and SSH commands 📤
- Ignore `terraform.tfstate` and friends; Terraform owns those. 🗃️


## Quick start 🚀
```bash
# 1. Copy and edit vars
cp terraform.tfvars.example terraform.tfvars

# 2. Initialize
terraform fmt -recursive
terraform init
terraform validate

# 3. Plan (dry run)
terraform plan

# 4. Deploy
terraform apply

# 5. Connect
terraform output ssh_commands
```

## Destroying VMs 🧨
```bash
# Delete all VMs
terraform apply -var='vms={}' -auto-approve
```
<br>
Happy VM farming 🖥️🌱🐧

