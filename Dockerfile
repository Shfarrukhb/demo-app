#build
FROM eclipse-temurin:17-jdk-alpine AS builder
COPY . /usr/src/myapp/
WORKDIR /usr/src/myapp/
RUN set -Eeux && apk --no-cache add maven
RUN mvn package

# exec
FROM eclipse-temurin:17-jre-alpine
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /usr/src/myapp/target/app.jar .
EXPOSE 8123
ENTRYPOINT ["java", "-jar", "./app.jar"]
