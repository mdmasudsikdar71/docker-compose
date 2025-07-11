# Makefile

# Define variables
DOCKER_COMPOSE = docker-compose
APP_CONTAINER = php

# Default target
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  up                   Start the Docker containers"
	@echo "  down                 Stop the Docker containers"
	@echo "  restart              Restart the Docker containers"
	@echo "  composer-update      Update PHP dependencies using Composer"
	@echo "  ssh                  Open a shell session inside the app container"

# Docker targets
.PHONY: up
up:
	$(DOCKER_COMPOSE) up -d

.PHONY: down
down:
	$(DOCKER_COMPOSE) down

.PHONY: restart
restart: down up

# Composer targets
.PHONY: composer-update
composer-update:
	$(DOCKER_COMPOSE) exec $(APP_CONTAINER) composer update

# SSH target
.PHONY: ssh
ssh:
	@read -p "Enter container name (default: $(APP_CONTAINER)): " name; \
	container=$${name:-$(APP_CONTAINER)}; \
	$(DOCKER_COMPOSE) exec $$container sh
