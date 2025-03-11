FROM eclipse-temurin:17-jdk-focal

WORKDIR /app

# Copy POM file and source code
COPY pom.xml ./
RUN apt-get update && apt-get install -y maven
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
