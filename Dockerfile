FROM openjdk:11-jre-slim
ARG JAR_FILE=target/*.jar
ARG OCI_CONFIG_FILE=config
ARG OCI_API_KEY=oci_api_key.pem
COPY ${JAR_FILE} app.jar
COPY ${OCI_API_KEY} oci_api_key.pem
ADD ${OCI_CONFIG_FILE} /root/.oci/
##COPY ${OCI_CONFIG_FILE}  r/.oci/
ENTRYPOINT ["java","-jar","/app.jar"]