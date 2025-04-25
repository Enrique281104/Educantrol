# Fase de construcción (compila el JAR con Maven)
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Fase de producción (solo JRE para reducir tamaño)
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar ./app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
