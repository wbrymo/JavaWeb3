# Stage 1: Build WAR using Maven
FROM maven:3.8.4-openjdk-11 AS builder
WORKDIR /app
COPY . .
RUN mvn dependency:go-offline
RUN mvn -B clean package -DskipTests

# Stage 2: Deploy WAR on Tomcat
FROM tomcat:9.0
COPY --from=builder /app/target/WebAppCal-0.0.6.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
