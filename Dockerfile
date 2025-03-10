# Stage 1: Build the application using Maven
FROM openjdk:17-jdk AS build
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src src

# Copy Maven wrapper files
COPY mvnw .
COPY .mvn .mvn

# Set execution permission for the Maven wrapper
RUN chmod +x ./mvnw

# Build the application
RUN ./mvnw clean package -DskipTests

# Stage 2: Create the final Docker image using OpenJDK 17
FROM openjdk:17-jdk
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]