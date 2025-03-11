FROM eclipse-temurin:17-jdk-focal

WORKDIR /app

# Install Maven
RUN apt-get update && apt-get install -y maven

# Copy the Maven configuration file and download dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copy the application source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Copy the JAR file to a standard location
RUN cp target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Use the PORT environment variable provided by Render, or default to 8080
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=${PORT:-8080}"]
