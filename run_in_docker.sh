docker stop newcuriosityms; docker rm newcuriosityms;

docker build --pull --no-cache --tag fra.ocir.io/frsxwtjslf35/wikipedia/demo/newcuriosityms:latest .


SPRING_DATASOURCE_PASSWORD=Welcome#1;
SPRING_DATASOURCE_USERNAME=spring;
SPRING_DATASOURCE_HOST=130.61.147.13;
SPRING_DATASOURCE_PORT=3306;
SPRING_DATASOURCE_DBNAME=curiositypdb;

#docker run --env SPRING_DATASOURCE_HOST='130.61.147.13' \
#-e SPRING_DATASOURCE_PORT='3306' -e SPRING_DATASOURCE_USERNAME='spring' -e SPRING_DATASOURCE_PASSWORD='Welcome#1' \ 
#-e SPRING_DATASOURCE_DBNAME='championshipdb' -p 9000:8091 --name myTomcatContainer fharris/champion:trouble;


#docker run -e SPRING_DATASOURCE_HOST='130.61.147.13' -e SPRING_DATASOURCE_PORT='3306' -e SPRING_DATASOURCE_USERNAME='spring' -e SPRING_DATASOURCE_PASSWORD='Welcome#1' -e SPRING_DATASOURCE_DBNAME='curiositydb' -p 9001:8090 --name newcuriosityms fra.ocir.io/frsxwtjslf35/wikipedia/demo/newcuriosityms:latest;



