# Use Eclipse Temurin JDK 17 base image
FROM eclipse-temurin:17-jdk-focal

# Set the working directory
WORKDIR /app

# Copy the Maven wrapper and pom.xml files
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy the rest of the application code
COPY src ./src

# Package the application
RUN ./mvnw clean package -DskipTests

# Copy the built JAR file to the app.jar
COPY target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
