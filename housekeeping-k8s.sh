#!/bin/bash

echo "Starting deleting Curiosity Microservices!"

echo Running in $SHELL


kubectl delete -f appconfig/curiosityms-namespace.yaml;
#kubectl delete ns mysql;
kubectl delete -f databaseconfig/mysql-persistentvolume.yaml;
kubectl delete -f databaseconfig/mysql-persistentvolumeclaim.yaml;
kubectl delete -f jenkins-k8s-config/jenkins-task-sa.yaml;
kubectl delete -f jenkins-k8s-config/jenkins-task-sa-secret.yaml;
kubectl delete -f jenkins-k8s-config/jenkins-clusterrole.yaml;
kubectl delete -f jenkins-k8s-config/jenkins-clusterrole-binding.yml;

