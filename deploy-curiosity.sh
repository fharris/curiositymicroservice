

echo "############################"
echo "############################"
echo "############################"
echo "############################"
echo "Deploying Curiosity Microservice"
echo "############################"
echo "############################"
echo "############################"
echo "############################"
kubectl apply -f appconfig/curiosityms-namespace.yaml;
kubectl apply -f ./databaseconfig/.
echo ".... waiting for MySQL pod to run to run db configuration...Deploying Curiosity Microservice"
echo "############################"
echo "############################"
sleep 45;
kubectl -n curiosityevents exec -it  `kubectl -n curiosityevents get \
 --no-headers=true pods -l app=mysql-db -o custom-columns=:metadata.name` \
 -- mysql -h 127.0.0.1 -u root -pmySQLpword#2023 < ./databaseconfig/create-curiositydb-resources.sql;
kubectl apply -f ./appconfig/. ;
echo "updating for a public accessible image of the application"
kubectl -n curiosityevents set image deployment/curiosityms-deployment curiosityms=fra.ocir.io/frsxwtjslf35/wikipedia/demo/curiosityms:latest
echo ".... waiting for the application to get deployed..."
sleep 20;
kubectl get pods -n curiosityevents;
echo "############################"
echo "Done... Have fun!"
echo "############################"

