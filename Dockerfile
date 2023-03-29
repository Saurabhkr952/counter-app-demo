FROM openjdk:17-jdk-slim AS deploy
WORKDIR /app
COPY ./target/*.jar .
EXPOSE 8080
CMD ["java", "-jar", "Uber.jar"]
