# Docker Compose Setup for Microservices and API Management

This document provides instructions on how to set up and access various services in your Docker Compose environment, including microservices, databases, API gateways, and management tools.

## Table of Contents
- [Docker Compose Setup for Microservices and API Management](#docker-compose-setup-for-microservices-and-api-management)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Services Overview](#services-overview)
  - [Getting Started](#getting-started)
  - [Accessing Services](#accessing-services)
    - [WSO2 API Manager](#wso2-api-manager)
    - [WSO2 Identity Server](#wso2-identity-server)
    - [Kong](#kong)
    - [Gravitee](#gravitee)
    - [Microservices](#microservices)
    - [Databases](#databases)
    - [Apache APISIX](#apache-apisix)
    - [Monitoring and Administration](#monitoring-and-administration)
  - [Login Credentials](#login-credentials)
  - [Initial Kong Setup](#initial-kong-setup)
  - [Configuration](#configuration)
  - [Troubleshooting](#troubleshooting)

## Prerequisites

- Docker and Docker Compose installed on your system
- Git (optional, for cloning the repository)

## Services Overview

This setup includes the following services:

- Microservices: claims-service, contract-service
- Databases: MySQL, PostgreSQL, MongoDB
- API Management: WSO2 API Manager, Gravitee
- API Gateways: Kong, Apache APISIX, Gravitee Gateway
- Monitoring: Prometheus, Grafana
- Administration: Konga (for Kong), APISIX Dashboard, Gravitee Management UI

## Getting Started

1. Clone the repository (if applicable):
   ```
   git clone https://github.com/sistemica/api-gateway-playground.git
   cd api-gateway-playground
   ```

2. Start the services:
   ```
   docker-compose up -d
   ```

3. Wait for all services to start (this may take a few minutes)

## Accessing Services

### WSO2 API Manager

1. Admin Portal
   - URL: https://localhost:9443/admin
   - Use: API creation and management

2. Publisher Portal
   - URL: https://localhost:9443/publisher
   - Use: API publishing

3. Developer Portal
   - URL: https://localhost:9443/devportal
   - Use: API subscription and testing

4. Carbon Management Console
   - URL: https://localhost:9443/carbon
   - Use: System administration

### WSO2 Identity Server

1. Management Console
   - URL: https://localhost:9444/carbon
   - Use: Identity and access management

### Kong

1. Admin API
   - URL: http://localhost:8001
   - Use: Kong administration and configuration via RESTful API calls

2. Proxy
   - URL: http://localhost:8000
   - Use: API Gateway for routing requests

3. Konga (Kong Admin GUI)
   - URL: http://localhost:1337
   - Use: Web-based admin interface for Kong

   Setting up Konga:
   - Access Konga at http://localhost:1337
   - On first run, you'll be prompted to create an admin account
   - After creating the admin account, log in to Konga
   - Go to "Connections" and add a new connection:
     - Name: local-kong
     - Kong Admin URL: http://kong:8001
   - Activate the connection

### Gravitee

1. Gravitee Gateway
   - URL: http://localhost:8083
   - Use: API Gateway for routing requests

2. Gravitee Management API
   - URL: http://localhost:8084
   - Use: API for managing Gravitee configuration

3. Gravitee Management UI
   - URL: http://localhost:3001
   - Use: Web-based admin interface for Gravitee

### Microservices

- Claims Service: 
  - URL: http://localhost:9081
  - Swagger UI: http://localhost:9081/swagger-ui.html

- Contract Service: 
  - URL: http://localhost:9082
  - Swagger UI: http://localhost:9082/swagger-ui.html

### Databases

- MySQL:
  - Host: localhost
  - Port: 3306
  - Database: WSO2AM_DB
  - Username: root
  - Password: root

- PostgreSQL:
  - Host: localhost
  - Port: 5432
  - Database: postgres
  - Username: postgres
  - Password: postgres

- MongoDB:
  - Host: localhost
  - Port: 27017
  - Database: gravitee

### Apache APISIX

- Gateway: http://localhost:9080
- Admin API: http://localhost:9180
- Dashboard: http://localhost:9001

### Monitoring and Administration

- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

## Login Credentials

For WSO2 interfaces, use the following default credentials:
- Username: admin
- Password: admin

For Gravitee Management UI, you may need to set up an admin account on first use. Refer to Gravitee documentation for specific instructions.

**Important:** It is highly recommended to change the default passwords after your first login.

## Initial Kong Setup

Kong is configured to run without a database (DB-less mode). To add services and routes to Kong, you'll need to use the Admin API. Here's a basic example:

1. Add a service:
   ```
   curl -i -X POST http://localhost:8001/services \
     --data name=example-service \
     --data url=http://claims-service:8080
   ```

2. Add a route for the service:
   ```
   curl -i -X POST http://localhost:8001/services/example-service/routes \
     --data 'paths[]=/claims' \
     --data name=claims-route
   ```

After this setup, requests to `http://localhost:8000/claims` will be proxied to the claims-service.

## Configuration

- APISIX configuration: `./apisix/apisix_conf/config.yaml`
- APISIX Dashboard configuration: `./apisix/dashboard_conf/conf.yaml`
- Prometheus configuration: `./apisix/prometheus_conf/prometheus.yml`
- Grafana configuration: `./apisix/grafana_conf/`
- Gravitee configurations are managed through environment variables in the docker-compose file.

## Troubleshooting

1. Check if all containers are running:
   ```
   docker-compose ps
   ```

2. View logs for a specific service:
   ```
   docker-compose logs <service-name>
   ```

3. Ensure all required ports are available on your host machine

4. For WSO2 API Manager, allow a few minutes for full startup

5. If encountering SSL certificate warnings in browsers, this is normal for a local setup. You can proceed by accepting the risk.

6. For Gravitee, check the logs of the gateway, management API, and UI containers if you encounter any issues:
   ```
   docker-compose logs gravitee-gateway
   docker-compose logs gravitee-management-api
   docker-compose logs gravitee-management-ui
   ```

Notes:
1. When accessing WSO2 URLs for the first time, you may encounter a security warning about the SSL certificate. This is normal for a local setup.
2. Always use `https://` instead of `http://` when accessing WSO2 URLs.
3. If you've modified the port mappings in your docker-compose file, adjust the port numbers in the URLs accordingly.

For more detailed configuration and usage instructions, refer to the official documentation for each component.
