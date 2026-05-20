output "manager_ip" {
  description = "IP адрес менеджера"
  value       = "192.168.10.51"
}

output "worker_ips" {
  description = "IP адреса воркеров"
  value       = ["192.168.10.52", "192.168.10.53"]
}