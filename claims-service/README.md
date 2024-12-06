# Claims Management Service

This project is a Spring Boot application that provides a RESTful API for managing insurance claims. It uses PostgreSQL as the database and includes Swagger UI for API documentation.

## Prerequisites

- Docker
- Docker Compose
- Make (optional, for using Makefile commands)

## Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/claims-management-service.git
   cd claims-management-service
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

- `POST /claims`: File a new claim
- `GET /claims/{id}`: Retrieve claim details
- `PUT /claims/{id}`: Update claim status
- `PUT /claims/{id}/file`: Upload a file relevant to the claim (e.g., picture or PDF)
- `GET /claims/status/{id}`: Get status of a claim

### Example curl commands

1. File a new claim:
   ```
   curl -X POST -H "Content-Type: application/json" -d '{"policyNumber":"POL123","description":"Car accident on Main St."}' http://localhost:8080/claims
   ```

2. Retrieve claim details (replace {id} with the actual claim ID):
   ```
   curl -X GET http://localhost:8080/claims/{id}
   ```

3. Update claim status (replace {id} with the actual claim ID):
   ```
   curl -X PUT -H "Content-Type: application/x-www-form-urlencoded" -d "status=In Progress" http://localhost:8080/claims/{id}
   ```

4. Upload a file for a claim (replace {id} with the actual claim ID and /path/to/file.pdf with the actual file path):
   ```
   curl -X PUT -H "Content-Type: multipart/form-data" -F "file=@/path/to/file.pdf" http://localhost:8080/claims/{id}/file
   ```

5. Get claim status (replace {id} with the actual claim ID):
   ```
   curl -X GET http://localhost:8080/claims/status/{id}
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
│       │           └── claimsservice/
│       │               ├── ClaimsServiceApplication.java
│       │               ├── controller/
│       │               │   └── ClaimController.java
│       │               ├── model/
│       │               │   └── Claim.java
│       │               ├── repository/
│       │               │   └── ClaimRepository.java
│       │               └── service/
│       │                   └── ClaimService.java
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

## File Upload

The service supports file uploads for claims. Files are stored in the `uploads` directory within the Docker container. The maximum file size is set to 10MB by default. You can change this limit in the `application.properties` file.

## Database

The service uses PostgreSQL as the database. The database is automatically created and initialized when you run the Docker containers. If you need to access the database directly, you can use the following command:

```
docker-compose exec db psql -U postgres -d claimsdb
```

## Troubleshooting

1. If you encounter permission issues with file uploads, make sure the `uploads` directory has the correct permissions:
   ```
   mkdir -p uploads
   chmod 777 uploads
   ```

2. If the service fails to start, check the logs for any error messages:
   ```
   docker-compose logs app
   ```

## Contributing

Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.