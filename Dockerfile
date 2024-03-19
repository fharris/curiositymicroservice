FROM maven:3.8.4-jdk-11-slim as maven

ENV SPRING_DATASOURCE_USERNAME spring
ENV SPRING_DATASOURCE_PASSWORD Welcome#1
ENV SPRING_DATASOURCE_HOST 130.61.147.13
ENV SPRING_DATASOURCE_PORT 3306
ENV SPRING_DATASOURCE_DBNAME curiositydb
#ENV OCI_CONFIG_STREAM_ENDPOINT na
#ENV OCI_CONFIG_STREAM_ID na
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

COPY --from=maven target/curiosity-0.0.1-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java","-jar","/app.jar"]