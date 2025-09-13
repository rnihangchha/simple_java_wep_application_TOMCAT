FROM maven:3.9.11-eclipse-temurin-21-alpine AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package checkstyle:checkstyle pmd:pmd 

FROM tomcat:10.1.46-jdk17-temurin
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh","run"]