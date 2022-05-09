FROM maven:3.8.4-jdk-11-slim as maven

ENV SPRING_DATASOURCE_USERNAME spring
ENV SPRING_DATASOURCE_PASSWORD Welcome#1
ENV SPRING_DATASOURCE_HOST 130.61.227.220
ENV SPRING_DATASOURCE_PORT 3306
ENV SPRING_DATASOURCE_DBNAME curiositydb
ENV OCI_CONFIG_STREAM_ENDPOINT https://cell-1.streaming.eu-frankfurt-1.oci.oraclecloud.com   
ENV OCI_CONFIG_STREAM_ID ocid1.stream.oc1.eu-frankfurt-1.amaaaaaauevftmqau7jfdmryoq7mpcaijbnmhqvuozxnx57sdcofedybfq5q    

COPY ./pom.xml ./pom.xml

COPY ./src ./src


RUN mvn dependency:go-offline -B

RUN mvn package

FROM openjdk:11-jre-slim

ENV SPRING_DATASOURCE_USERNAME spring
ENV SPRING_DATASOURCE_PASSWORD Welcome#1
ENV SPRING_DATASOURCE_HOST 130.61.227.220
ENV SPRING_DATASOURCE_PORT 3306
ENV SPRING_DATASOURCE_DBNAME curiositydb
ENV OCI_CONFIG_STREAM_ENDPOINT https://cell-1.streaming.eu-frankfurt-1.oci.oraclecloud.com   
ENV OCI_CONFIG_STREAM_ID ocid1.stream.oc1.eu-frankfurt-1.amaaaaaauevftmqau7jfdmryoq7mpcaijbnmhqvuozxnx57sdcofedybfq5q   

ARG OCI_CONFIG_FILE=config
ARG OCI_API_KEY=oci_api_key.pem

COPY ${OCI_API_KEY} oci_api_key.pem
ADD ${OCI_CONFIG_FILE} /root/.oci/

COPY --from=maven target/curiosity-0.0.1-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java","-jar","/app.jar"]