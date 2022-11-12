| Language | Framework | Platform | Author |
| -------- | -------- |--------|--------|
| Java | Spring | Azure Kubernetes Service| forked by andrewmin |


# Java Spring boot web application

Sample Java Spring Boot web application using Azure PostgreSQL

## Prequisite

Azure PostgreSQL should be already run.

## How to run

### Maven build

```bash
    ./mvnw package
```

### Docker build and run

    * Replace postgres service name

```bash
    export POSTGRES_URL='jdbc:postgresql://<your-postgres-name>.postgres.database.azure.com/petclinic?sslmode=verify-full&&sslfactory=org.postgresql.ssl.SingleCertValidatingFactory&sslfactoryarg=classpath:BaltimoreCyberTrustRoot.crt.pem'

    export POSTGRES_USER=<your-postgres-user>

    export POSTGRES_PASS=<your-postgres-password>
    
    docker docker build -t pet .

    docker run pet -e POSTGRES_URL=$POSTGRES_URL -e POSTGRES_USER=$POSTGRES_USER -e POSTGRES_PASS=$POSTGRES_PASS 
```

## License:

See [LICENSE](LICENSE).

## Contributing

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

