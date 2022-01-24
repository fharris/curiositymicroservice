#FROM openjdk:11-jre-slim
#ARG JAR_FILE=target/*.jar
#ARG OCI_CONFIG_FILE=config
#ARG OCI_API_KEY=oci_api_key.pem
#COPY ${JAR_FILE} app.jar
#COPY ${OCI_API_KEY} oci_api_key.pem
#ADD ${OCI_CONFIG_FILE} /root/.oci/
###COPY ${OCI_CONFIG_FILE}  r/.oci/
#ENTRYPOINT ["java","-jar","/app.jar"]


FROM maven:3.8.4-jdk-11-slim as maven

ENV SPRING_DATASOURCE_USERNAME spring
ENV SPRING_DATASOURCE_PASSWORD Welcome#1

ARG OCI_CONFIG_FILE=config
ARG OCI_API_KEY=oci_api_key.pem

COPY ${OCI_API_KEY} oci_api_key.pem
ADD ${OCI_CONFIG_FILE} /root/.oci/

COPY ./pom.xml ./pom.xml

COPY ./src ./src

RUN mvn dependency:go-offline -B

RUN mvn package

FROM openjdk:11-jre-slim

COPY --from=maven target/curiosity-0.0.1-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java","-jar","/app.jar"]