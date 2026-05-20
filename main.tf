terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.106.0"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://${var.proxmox_host}:8006/"
  api_token = "${var.proxmox_token_id}=${var.proxmox_token_secret}"
  insecure  = true
}

# Менеджер
resource "proxmox_virtual_environment_vm" "manager" {
  name      = "swarm-manager"
  node_name = var.proxmox_node

  clone {
    vm_id = data.proxmox_virtual_environment_vms.template.vms[0].vm_id
    full  = false
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.10.51/24"
        gateway = "192.168.10.1"
      }
    }
    user_account {
      username = "ubuntu"
      keys     = [var.ssh_public_key]
    }
  }
}

# Воркеры
resource "proxmox_virtual_environment_vm" "worker" {
  count     = 2
  name      = "swarm-worker-${count.index + 1}"
  node_name = var.proxmox_node

  clone {
    vm_id = data.proxmox_virtual_environment_vms.template.vms[0].vm_id
    full  = false
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.10.5${count.index + 2}/24"
        gateway = "192.168.10.1"
      }
    }
    user_account {
      username = "ubuntu"
      keys     = [var.ssh_public_key]
    }
  }
}

# Поиск шаблона по имени
data "proxmox_virtual_environment_vms" "template" {
  filter {
    name   = "name"
    values = [var.template_name]
  }
}