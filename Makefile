# Docker compose configuration
DOCKER_COMPOSE=docker compose -f compose.yml

# Color codes for better visibility
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m # No Color

# Mark all targets as PHONY (not files)
.PHONY: help all start stop clean logs ps start-services stop-services logs-services status

#######################
# Main Commands
#######################

# Default target shows help
help:
	@echo "Available commands:"
	@echo "Main commands:"
	@echo "  ${GREEN}make all${NC}         - Start all services"
	@echo "  ${GREEN}make stop${NC}        - Stop all services"
	@echo "  ${GREEN}make clean${NC}       - Stop all containers and remove volumes"
	@echo "  ${GREEN}make status${NC}      - Show status of all containers"
	@echo "Sample Services:"
	@echo "  ${GREEN}make start-services${NC} - Start sample services (Claims/Contract)"
	@echo "  ${GREEN}make stop-services${NC}  - Stop sample services"
	@echo "  ${GREEN}make logs-services${NC}  - Show sample services logs"
	@echo "Logs:"
	@echo "  ${GREEN}make logs${NC}        - Show logs from all containers"

# Start all services
all: start-services
	@echo "${GREEN}All services started${NC}"

# Stop all services
stop: stop-services
	@echo "${RED}All services stopped${NC}"

#######################
# Sample Services 
#######################
start-services:
	@echo "Starting services..."
	@$(DOCKER_COMPOSE) up -d postgres claims-service contract-service
	@echo "${GREEN}Services started${NC}"

stop-services:
	@echo "Stopping services..."
	@$(DOCKER_COMPOSE) down --remove-orphans
	@echo "${RED}Services stopped${NC}"

logs-services:
	@$(DOCKER_COMPOSE) logs -f claims-service contract-service

#######################
# Utility Commands
#######################
# Show logs for all containers
logs:
	@$(DOCKER_COMPOSE) logs -f

# Clean all containers and volumes
clean:
	@echo "Cleaning up all containers and volumes..."
	@$(DOCKER_COMPOSE) down -v --remove-orphans
	@echo "${RED}All containers and volumes removed${NC}"

# Show status of all containers
status:
	@echo "Current container status:"
	@$(DOCKER_COMPOSE) ps
