# Microservices Example Setup

This repository contains a simple microservices setup with sample services and monitoring tools.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git (for cloning the repository)

## Services Overview

This setup includes the following services:

- **Microservices**:
  - Claims Service
  - Contract Service
- **Database**:
  - PostgreSQL
- **Monitoring**:
  - Prometheus
  - Grafana

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/sistemica/api-gateway-playground.git
   cd api-gateway-playground
   ```

2. Start all services:
   ```bash
   make all
   ```

## Accessing Services

### Microservices

- Claims Service: 
  - URL: http://localhost:9081
  - Swagger UI: http://localhost:9081/swagger-ui.html

- Contract Service: 
  - URL: http://localhost:9082
  - Swagger UI: http://localhost:9082/swagger-ui.html

### Database

PostgreSQL:
  - Host: localhost
  - Port: 5432
  - Database: postgres
  - Username: postgres
  - Password: postgres

### Monitoring

- Prometheus: http://localhost:9090
- Grafana: http://localhost:9000

## Available Make Commands

- `make all` - Start all services
- `make stop` - Stop all services
- `make clean` - Stop all containers and remove volumes
- `make status` - Show status of all containers
- `make logs` - Show logs from all containers
- `make start-services` - Start sample services (Claims/Contract)
- `make stop-services` - Stop sample services
- `make logs-services` - Show sample services logs

## Troubleshooting

1. Check if all containers are running:
   ```bash
   make status
   ```

2. View logs for services:
   ```bash
   make logs
   ```

3. Ensure all required ports are available on your host machine

For more detailed configuration and usage instructions, refer to the documentation of each component.
