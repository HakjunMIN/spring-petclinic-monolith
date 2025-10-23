FROM mcr.microsoft.com/openjdk/jdk:21-distroless

COPY ./target/*.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
