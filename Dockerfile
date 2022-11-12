FROM mcr.microsoft.com/java/jre-headless:11-zulu-ubuntu

COPY ./target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
