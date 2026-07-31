FROM eclipse-temurin:25-jre
LABEL maintainer="Vasanth Kumar"
WORKDIR /app
COPY jackson-java.jar jackson-java.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "jackson-java.jar"]
