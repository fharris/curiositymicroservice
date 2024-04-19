
docker stop newcuriosityms; docker rm newcuriosityms;

#docker build --pull --no-cache --tag fra.ocir.io/frsxwtjslf35/wikipedia/demo/newcuriosityms:latest .


SPRING_DATASOURCE_PASSWORD=Welcome#1;
SPRING_DATASOURCE_USERNAME=spring;
#SPRING_DATASOURCE_HOST=130.61.147.13;
SPRING_DATASOURCE_HOST=localhost
SPRING_DATASOURCE_PORT=3306;
SPRING_DATASOURCE_DBNAME=curiositydb;

#docker run --env SPRING_DATASOURCE_HOST='130.61.147.13' \
#-e SPRING_DATASOURCE_PORT='3306' -e SPRING_DATASOURCE_USERNAME='spring' -e SPRING_DATASOURCE_PASSWORD='Welcome#1' \ 
#-e SPRING_DATASOURCE_DBNAME='championshipdb' -p 9000:8091 --name myTomcatContainer fharris/champion:trouble;


#docker run -e SPRING_DATASOURCE_HOST='130.61.147.13' -e SPRING_DATASOURCE_PORT='3306' -e SPRING_DATASOURCE_USERNAME='spring' -e SPRING_DATASOURCE_PASSWORD='Welcome#1' -e SPRING_DATASOURCE_DBNAME='curiositydb' -p 9001:8090 --name newcuriosityms fra.ocir.io/frsxwtjslf35/wikipedia/demo/newcuriosityms:latest;


KAFKA_BOOTSTRAP_SERVERS=kafka-service.kafka.svc.cluster.local:9092
KAFKA_CONSUMER_GROUP_ID=myGroupCuriosity2

echo $KAFKA_BOOTSTRAP_SERVERS;

docker build --pull --no-cache  --build-arg SPRING_DATASOURCE_USERNAME=spring --build-arg SPRING_DATASOURCE_PASSWORD=Welcome#1 --build-arg SPRING_DATASOURCE_HOST='130.61.147.13' --build-arg SPRING_DATASOURCE_PORT='3306' --build-arg SPRING_DATASOURCE_DBNAME=curiositydb   --tag fra.ocir.io/frsxwtjslf35/wikipedia/demo/curiosityms:latest .

#docker build --no-cache -t your-image-name .


#docker run --env SPRING_DATASOURCE_HOST='130.61.147.13' \
#-e SPRING_DATASOURCE_PORT='3306' -e SPRING_DATASOURCE_USERNAME='spring' -e SPRING_DATASOURCE_PASSWORD='Welcome#1' \ 
#-e SPRING_DATASOURCE_DBNAME='championshipdb' -p 9000:8091 --name myTomcatContainer fharris/champion:trouble;


#docker run -e SPRING_DATASOURCE_HOST='130.61.147.13' -e SPRING_DATASOURCE_PORT='3306' -e SPRING_DATASOURCE_USERNAME='spring' -e SPRING_DATASOURCE_PASSWORD='Welcome#1' -e SPRING_DATASOURCE_DBNAME='curiositydb' -p 9001:8095 --name troubleconsumerms fra.ocir.io/frsxwtjslf35/wikipedia/demo/troubleconsumerms:latest;