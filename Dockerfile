FROM maven:3.8.4-jdk-11-slim as maven

ARG SPRING_DATASOURCE_USERNAME 
ARG SPRING_DATASOURCE_PASSWORD
ARG SPRING_DATASOURCE_HOST
ARG SPRING_DATASOURCE_PORT
ARG SPRING_DATASOURCE_DBNAME

#using localhost:9092 for local kafka to avoid the need of setting up a kafka cluster inside the context of VBStudio
#once in kubernetes values will come from configmap environment variables
ENV KAFKA_BOOTSTRAP_SERVERS localhost:9092 
ENV KAFKA_PRODUCER_BOOTSTRAP_SERVERS localhost:9092
ENV KAFKA_CONSUMER_BOOTSTRAP_SERVERS localhost:9092
ENV KAFKA_CONSUMER_GROUP_ID myGroupCuriosity2    

COPY ./pom.xml ./pom.xml
COPY ./src ./src

RUN mvn dependency:go-offline -B

RUN mvn package

FROM openjdk:11-jre-slim

COPY --from=maven src/* ./src/
COPY --from=maven target/curiosity-0.0.1-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java","-jar","/app.jar"]