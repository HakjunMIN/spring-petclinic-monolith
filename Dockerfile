FROM mcr.microsoft.com/java/jre-headless:11-zulu-ubuntu

ENV POSTGRES_URL=
ENV POSTGRES_USER=
ENV POSTGRES_PASS=

COPY ./target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
# ENTRYPOINT ["java", "-Dspring.profiles.active=h2", "-jar", "/app.jar"]