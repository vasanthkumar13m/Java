FROM eclipse-temurin:25-jre
LABEL maintainer="Vasanth Kumar"
WORKDIR /app
COPY petclinic.jar petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "petclinic.jar"]
