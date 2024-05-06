**Manual deployment**

Get the code from GitHub If you haven’t done so, get the code from the repository with the below command:
git clone https://github.com/fharris/curiositymicroservice

***1-Create the curiosityevents namespace***
You can start by running the housekeeping-k8s script first to clean everything if this is not the first time you are doing the set-up. Change to the curiositymicroservice folder and run the following commands:

```
./housekeeping-k8s.sh
```

If you just want to see the app running and leave the manual steps to study later just run the following script:

```
./deploy-curiosity.sh
```

If all goes well, you may jump to step 5 to run the application and ignore the rest of the steps.

If you want to install things step by step, then, once everything is cleaned with the housekeeping script, try to create the namespace with the following command:

```
kubectl apply -f appconfig/curiosityms-namespace.yaml
```

***2-Deploy database***
Deploy the MySQL database with the following command:

```
kubectl apply -f ./databaseconfig/.
```

You will notice that the password in the mysql-db-secret.yaml is set to the base64 of mySQLpword#2023. If you change the password, please don’t forget to take note of that.

***3-Configure the mysql database for the application***

When the mysql pod is running, run the following command to create the user curiosity and the database curiositydb:

```
kubectl -n curiosityevents exec -it kubectl -n curiosityevents get \ --no-headers=true pods -l app=mysql-db -o custom-columns=:metadata.name
-- mysql -h 127.0.0.1 -u root -pmySQLpword#2023 < ./databaseconfig/create-curiositydb-resources.sql
```

***4-Deploy the application***
Deploy the application with the following command:

```
kubectl apply -f ./appconfig/.
```

***5-Test the application***
If all goes well, check that you have successfully deployed the application and the database with the following command:

```
kubectl get pods -n curiosityevents
```

You should be able to see 4 applications running. The curiosity microservice pods, the MySQL database pods and the Zookeeper and Kafka pods:

![image](https://github.com/fharris/curiositymicroservice/assets/17484224/8be1e2f8-dcd6-4215-8943-5338dd837f13)




Open the repository for the curiosityfrontendmicroservice and repeat the equivalent steps to install it as well.

***6-Install the Curiosity frontend***

[Curiosity Frontend Installation Page](https://github.com/fharris/curiosityfrontendmicroservice/blob/main/manualdeployment.md)


When the frontend is installed, open the repository for the championship microservice and repeat the equivalent steps to install it as well.

***7-Install the Championship microservice***

[Championship Microservice Installation Page](https://github.com/fharris/curiositychampionship/blob/main/manual-deployment.md)




