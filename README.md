# 🐳 Multi-Tech Docker Compose Monorepo

This repository contains Docker Compose setups for multiple technologies and services, each organized into its own folder with isolated `docker-compose.yml` files.

Ideal for full-stack, polyglot, or microservices development environments.

---

## 🚀 Quick Start

Each service runs independently using its own `docker-compose.yml`. Navigate to any folder and spin up the stack.

Repeat for any other tech stack.

---

## 🔧 Included Environments

| Tech Stack     | Description                        | Default Port |
| -------------- | ---------------------------------- | ------------ |
| **PHP**        | PHP with FPM and optional configs  | -            |
| **Go**         | Go (hot reload via Air)            | 8000         |
| **Python**     | Python (FastAPI/Flask ready)       | 8000         |
| **Node.js**    | Node environment (Express, etc.)   | 3000         |
| **Nginx**      | Reverse proxy or static server     | 80, 443      |
| **MySQL**      | Relational database                | 3306         |
| **PostgreSQL** | Relational database                | 5432         |
| **phpMyAdmin** | GUI for MySQL                      | 8030         |
| **Adminer**    | Universal DB GUI (MySQL, PG, etc.) | 8080         |
| **Redis**      | In-memory cache/database           | 6379         |

---

## 🌐 Custom Network

Each `docker-compose.yml` defines and uses a custom `bridge` network named `network` to allow inter-container communication.

```yaml
networks:
  network:
    driver: bridge
```

> Make sure to use the correct container names for internal service connections (e.g., `mysql`, `postgres`, etc.)

---

## 📦 Requirements

* Docker
* Docker Compose (v2 recommended)

---

## 🛠️ Author

**MD Masud Sikdar**
📧 [masudsikdar85@gmail.com](mailto:masudsikdar85@gmail.com)
