variable "proxmox_host" {
  description = "IP адрес Proxmox хоста"
}

variable "proxmox_token_id" {
  description = "API токен ID, например root@pam!terraform"
}

variable "proxmox_token_secret" {
  description = "Секрет токена"
  sensitive   = true
}

variable "proxmox_node" {
  description = "Имя ноды Proxmox"
}

variable "template_name" {
  description = "Имя шаблона VM"
}

variable "ssh_public_key" {
  description = "Публичный SSH ключ для доступа к VM"
}