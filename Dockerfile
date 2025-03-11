FROM eclipse-temurin:17-jdk-focal

WORKDIR /app

# Copy Maven Wrapper files
COPY .mvn/ .mvn
COPY mvnw mvnw.cmd pom.xml ./

RUN ./mvnw dependency:go-offline

COPY src ./src

RUN ./mvnw clean package -DskipTests

# Instead of copying a specific .jar, copy all files and rename the .jar we need
RUN cp target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
