# Spring Boot Contract Service

This project is a Spring Boot application that provides a RESTful API for managing contracts. It uses PostgreSQL as the database and includes Swagger UI for API documentation.

## Prerequisites

- Docker
- Docker Compose
- Make (optional, for using Makefile commands)

## Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/spring-boot-contract-service.git
   cd spring-boot-contract-service
   ```

2. Build the project:
   ```
   make build
   ```
   or
   ```
   docker-compose build
   ```

3. Run the service:
   ```
   make run
   ```
   or
   ```
   docker-compose up
   ```

The service will be available at `http://localhost:8080`.

## API Endpoints

The service exposes the following endpoints:

- `POST /api/contracts`: Create a new contract
- `GET /api/contracts/{id}`: Retrieve a contract by ID

### Example curl commands

1. Create a new contract:
   ```
   curl -X POST -H "Content-Type: application/json" -d '{"title":"Test Contract","description":"This is a test contract"}' http://localhost:8080/api/contracts
   ```

2. Retrieve a contract by ID (replace {id} with the actual ID):
   ```
   curl -X GET http://localhost:8080/api/contracts/{id}
   ```

## Swagger UI

The Swagger UI is available at `http://localhost:8080/swagger-ui.html`. You can use this interface to explore and test the API endpoints directly in your browser.

## API Documentation

The OpenAPI documentation is available at `http://localhost:8080/api-docs`.

## Stopping the Service

To stop and clean up the service, run:
```
make clean
```
or
```
docker-compose down
docker-compose rm -f
```

## Project Structure

```
project-root/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           └── contractservice/
│       │               ├── ContractServiceApplication.java
│       │               ├── controller/
│       │               │   └── ContractController.java
│       │               ├── model/
│       │               │   └── Contract.java
│       │               ├── repository/
│       │               │   └── ContractRepository.java
│       │               └── service/
│       │                   └── ContractService.java
│       └── resources/
│           └── application.properties
├── Dockerfile
├── docker-compose.yml
├── pom.xml
├── Makefile
└── README.md
```

## Development

To make changes to the project:

1. Stop the running service (if it's running)
2. Make your changes to the Java files
3. Rebuild the project: `make build`
4. Run the service again: `make run`

Remember to update the tests and documentation as necessary when making changes to the API.

## Contributing

Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.