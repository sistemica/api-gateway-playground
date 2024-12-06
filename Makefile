# Docker compose configuration
DOCKER_COMPOSE=docker compose -f compose.yml

# Color codes for better visibility
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m # No Color

# Mark all targets as PHONY (not files)
.PHONY: help all start stop clean logs ps \
        wso2 kong apisix gravitee \
        start-wso2 start-kong start-apisix start-gravitee \
        stop-wso2 stop-kong stop-apisix stop-gravitee \
        logs-wso2 logs-kong logs-apisix logs-gravitee \
        clean-volumes status

#######################
# Main Commands
#######################

# Default target shows help
help:
	@echo "Available commands:"
	@echo "Main commands:"
	@echo "  ${GREEN}make all${NC}         - Start all API gateways"
	@echo "  ${GREEN}make stop${NC}        - Stop all API gateways"
	@echo "  ${GREEN}make clean${NC}       - Stop all containers and remove volumes"
	@echo "  ${GREEN}make status${NC}      - Show status of all containers"
	@echo "Individual gateways:"
	@echo "  ${GREEN}make start-wso2${NC}     - Start WSO2 API Manager"
	@echo "  ${GREEN}make start-kong${NC}     - Start Kong and Konga"
	@echo "  ${GREEN}make start-apisix${NC}   - Start APISIX and Dashboard"
	@echo "  ${GREEN}make start-gravitee${NC} - Start Gravitee stack"
	@echo "Logs:"
	@echo "  ${GREEN}make logs${NC}        - Show logs from all containers"
	@echo "  ${GREEN}make logs-wso2${NC}   - Show WSO2 logs"
	@echo "  ${GREEN}make logs-kong${NC}   - Show Kong logs"
	@echo "  ${GREEN}make logs-apisix${NC} - Show APISIX logs"
	@echo "Sample Services:"
	@echo "  ${GREEN}make start-services${NC} - Start sample services (Claims/Contract)"
	@echo "  ${GREEN}make stop-services${NC}  - Stop sample services"
	@echo "  ${GREEN}make logs-services${NC}  - Show sample services logs"

# Start all gateways
all: start-wso2 start-kong start-apisix start-gravitee
	@echo "${GREEN}All API gateways started${NC}"

# Stop all gateways
stop: stop-wso2 stop-kong stop-apisix stop-gravitee
	@echo "${RED}All API gateways stopped${NC}"

#######################
# WSO2 Gateway
#######################
start-wso2:
	@echo "Starting WSO2 API Manager..."
	@$(DOCKER_COMPOSE) up -d mysql wso2
	@echo "${GREEN}WSO2 API Manager started${NC}"

stop-wso2:
	@echo "Stopping WSO2 API Manager..."
	@$(DOCKER_COMPOSE) down --remove-orphans wso2 mysql
	@echo "${RED}WSO2 API Manager stopped${NC}"

#######################
# Kong Gateway
#######################
start-kong:
	@echo "Starting Kong and Konga..."
	@$(DOCKER_COMPOSE) up -d kong konga
	@echo "${GREEN}Kong and Konga started${NC}"

stop-kong:
	@echo "Stopping Kong and Konga..."
	@$(DOCKER_COMPOSE) down --remove-orphans kong konga
	@echo "${RED}Kong and Konga stopped${NC}"

#######################
# APISIX Gateway
#######################
start-apisix:
	@echo "Starting APISIX..."
	@$(DOCKER_COMPOSE) up -d etcd apisix apisix-dashboard
	@echo "${GREEN}APISIX and Dashboard started${NC}"

stop-apisix:
	@echo "Stopping APISIX..."
	@$(DOCKER_COMPOSE) down --remove-orphans apisix apisix-dashboard etcd
	@echo "${RED}APISIX and Dashboard stopped${NC}"

#######################
# Gravitee Gateway
#######################
start-gravitee:
	@echo "Starting Gravitee..."
	@$(DOCKER_COMPOSE) up -d mongodb elasticsearch gravitee-gateway gravitee-management_api gravitee-management_ui gravitee-portal_ui
	@echo "${GREEN}Gravitee stack started${NC}"

stop-gravitee:
	@echo "Stopping Gravitee..."
	@$(DOCKER_COMPOSE) down --remove-orphans gravitee-gateway gravitee-management_api gravitee-management_ui gravitee-portal_ui mongodb elasticsearch
	@echo "${RED}Gravitee stack stopped${NC}"


#######################
# Sample Services 
#######################
start-services:
	@echo "Starting sample services..."
	@$(DOCKER_COMPOSE) up -d postgres claims-service contract-service
	@echo "${GREEN}Sample services started${NC}"

stop-services:
	@echo "Stopping sample services..."
	@$(DOCKER_COMPOSE) down --remove-orphans claims-service contract-service postgres
	@echo "${RED}Sample services stopped${NC}"

#######################
# Utility Commands
#######################
# Show logs for all containers
logs:
	@$(DOCKER_COMPOSE) logs -f

# Show logs for specific gateways
logs-wso2:
	@$(DOCKER_COMPOSE) logs -f wso2

logs-kong:
	@$(DOCKER_COMPOSE) logs -f kong konga

logs-apisix:
	@$(DOCKER_COMPOSE) logs -f apisix apisix-dashboard

logs-gravitee:
	@$(DOCKER_COMPOSE) logs -f gravitee-gateway gravitee-management_api gravitee-management_ui gravitee-portal_ui

# Clean all containers and volumes
clean:
	@echo "Cleaning up all containers and volumes..."
	@$(DOCKER_COMPOSE) down -v --remove-orphans
	@echo "${RED}All containers and volumes removed${NC}"

# Show status of all containers
status:
	@echo "Current container status:"
	@$(DOCKER_COMPOSE) ps