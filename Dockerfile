FROM openjdk:11-jre-slim
ARG JAR_FILE=target/*.jar
ARG OCI_CONFIG_FILE=config
ARG OCI_API_KEY=oci_api_key.pem
COPY ${JAR_FILE} app.jar
COPY ${OCI_API_KEY} oci_api_key.pem
ADD ${OCI_CONFIG_FILE} /root/.oci/
##COPY ${OCI_CONFIG_FILE}  r/.oci/
RUN apt update && sudo apt upgrade
RUN apt install curl
ENTRYPOINT ["java","-jar","/app.jar"]