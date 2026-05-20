# Sock Shop — IaC Deploy on Proxmox

Деплой демо-приложения [Sock Shop](https://microservices-demo.github.io/) на домашний Proxmox кластер через Terraform + Ansible + Docker Swarm.

## Стек

- **Terraform** — поднимает 3 VM на Proxmox
- **Ansible** — устанавливает Docker, настраивает Swarm, деплоит приложение
- **Docker Swarm** — оркестрация контейнеров

## Инфраструктура

| Хост | IP | Роль |
|---|---|---|
| swarm-manager | 192.168.10.51 | Swarm Manager |
| swarm-worker-1 | 192.168.10.52 | Swarm Worker |
| swarm-worker-2 | 192.168.10.53 | Swarm Worker |

## Быстрый старт

1. Заполни переменные
\```
cp terraform.tfvars.example terraform.tfvars
\```

2. Подними VM
\```
terraform init
terraform apply
\```

3. Задеплой приложение
\```
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
\```

4. Открой браузер: `http://192.168.10.51`
