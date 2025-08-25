# ======================================================
# Universal Makefile for WordPress Docker Development
# ======================================================
#
# Features:
# - Works on Linux, macOS, and Windows (PowerShell/Git Bash)
# - Prompts for container name at runtime
# - Handles different plugin/theme paths for `php` and `node` containers
# - Provides easy shortcuts for docker-compose workflow
# - Shows user-friendly messages when performing actions
#
# Best Practices:
# 1. Keep OS-specific logic at the top.
# 2. Use PHONY for non-file targets.
# 3. Provide a help target for self-documenting.
# 4. Show messages before executing commands.
# ======================================================

# Use POSIX sh for Linux/macOS; Windows recipes use PowerShell
SHELL := /bin/sh
DOCKER_COMPOSE = docker-compose

# ------------------------------------------------------
# Detect OS once and define runtime prompt command
# ------------------------------------------------------
ifeq ($(OS),Windows_NT)
    PROMPT_CMD = powershell -Command "Read-Host 'Enter container name'"
    IS_WINDOWS = 1
else
    PROMPT_CMD = bash -c 'read -p "Enter container name: " c; echo $$c'
    IS_WINDOWS = 0
endif

# ------------------------------------------------------
# Helper function to get container path
# Usage: $(call CONTAINER_PATH,container_name,plugins|themes)
# Returns the correct path depending on container type
# ------------------------------------------------------
define CONTAINER_PATH
if [ "$$1" = "node" ]; then \
    echo "/var/www/html/dashboard/wp-content/$(2)"; \
else \
    echo "/var/www/html/wp-content/$(2)"; \
fi
endef

# ======================================================
# HELP TARGET
# ======================================================
.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  up        → start Docker containers"
	@echo "  down      → stop Docker containers"
	@echo "  restart   → restart Docker containers"
	@echo "  ssh       → prompt for container, open shell"
	@echo "  plugin    → prompt for container, open plugin path"
	@echo "  theme     → prompt for container, open theme path"

# ======================================================
# DOCKER LIFECYCLE TARGETS
# ======================================================

# Start all containers
.PHONY: up
up:
	@echo "[INFO] Starting Docker containers..."
	$(DOCKER_COMPOSE) up -d
	@echo "[INFO] Containers started."

# Stop all containers
.PHONY: down
down:
	@echo "[INFO] Stopping Docker containers..."
	$(DOCKER_COMPOSE) down
	@echo "[INFO] Containers stopped."

# Restart all containers
.PHONY: restart
restart:
	@$(MAKE) down
	@$(MAKE) up

# ======================================================
# INTERACTIVE CONTAINER COMMANDS
# ======================================================

# Open a shell inside a container
.PHONY: ssh
ssh:
	@echo "[INFO] Opening shell inside container..."
ifeq ($(IS_WINDOWS),1)
	@powershell -Command "$$container = Read-Host 'Enter container name'; \
		$(DOCKER_COMPOSE) exec $$container sh"
else
	@bash -c 'read -p "Enter container name: " container; \
		$(DOCKER_COMPOSE) exec $$container sh'
endif
	@echo "[INFO] Shell session ended."

# Open plugin folder inside container
.PHONY: plugin
plugin:
	@echo "[INFO] Opening plugin folder inside container..."
ifeq ($(IS_WINDOWS),1)
	@powershell -Command "$$container = Read-Host 'Enter container name'; \
		$$path = if ($$container -eq 'node') { '/var/www/html/dashboard/wp-content/plugins' } else { '/var/www/html/wp-content/plugins' }; \
		$(DOCKER_COMPOSE) exec $$container sh -c \"cd $$path && exec sh\""
else
	@bash -c 'read -p "Enter container name: " container; \
		path=$$(if [ "$$container" = "node" ]; then echo /var/www/html/dashboard/wp-content/plugins; else echo /var/www/html/wp-content/plugins; fi); \
		$(DOCKER_COMPOSE) exec $$container sh -c "cd $$path && exec sh"'
endif
	@echo "[INFO] Plugin folder session ended."

# Open theme folder inside container
.PHONY: theme
theme:
	@echo "[INFO] Opening theme folder inside container..."
ifeq ($(IS_WINDOWS),1)
	@powershell -Command "$$container = Read-Host 'Enter container name'; \
		$$path = if ($$container -eq 'node') { '/var/www/html/dashboard/wp-content/themes' } else { '/var/www/html/wp-content/themes' }; \
		$(DOCKER_COMPOSE) exec $$container sh -c \"cd $$path && exec sh\""
else
	@bash -c 'read -p "Enter container name: " container; \
		path=$$(if [ "$$container" = "node" ]; then echo /var/www/html/dashboard/wp-content/themes; else echo /var/www/html/wp-content/themes; fi); \
		$(DOCKER_COMPOSE) exec $$container sh -c "cd $$path && exec sh"'
endif
	@echo "[INFO] Theme folder session ended."
