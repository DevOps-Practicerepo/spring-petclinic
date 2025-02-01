FROM maven:3.9-eclipse-temurin-17 AS maven_install
COPY . /spc
WORKDIR /spc
RUN mvn package

FROM eclipse-temurin:17-alpine
LABEL org="spc build" author="venkat"
ARG USERNAME=spc
RUN apk add --no-cache bash
RUN adduser -D -h /apps -s /bin/bash/ ${USERNAME}
USER ${USERNAME}
COPY --from=maven_install --chown={USERNAME}:{USERNAME} /spc/target/spring-petclinic-3.4.0-SNAPSHOT.jar /apps/spring-petclinic-3.4.0-SNAPSHOT.jar
WORKDIR /apps
EXPOSE 8080

