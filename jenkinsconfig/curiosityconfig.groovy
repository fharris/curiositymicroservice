#!/usr/bin/env groovy

pipeline {
  environment {
    //registry = "fharris/curiosity"
    //registryCredential = 'id-docker-registry'
    dockerImageBuild = ''
    dockerImageLatest = ''
    MYSQL_CREDENTIALS = credentials('id-mysql')
    //kubernetes_proxy = 'https://192.168.5.15:6443'
    kubernetes_proxy = "${env.KUBERNETES_ENDPOINT}"
  }
  agent any
  stages{
      
      
      
    stage('Get source code') {
      steps {
        git branch: 'main', 
            url: 'http://gogs:3000/gogs-user/curiositymicroservice.git'
      }
    }
    
    
    stage('Checkout code') {
        steps {
            checkout scm
        }
    }
   
    
      stage('Listing source code') {
      steps {
        sh 'ls -ltra'
      }
    }

     stage('Configuring Kafka in Kubernetes') {
      steps {
        withKubeConfig( credentialsId: 'jenkins-token-kubernetes', serverUrl: kubernetes_proxy ) {
	          sh "kubectl apply -f appconfig/curiosityms-namespace.yaml"
            sh "kubectl apply -f kafkaconfig/zookeeper-deploy.yaml"
            sh "kubectl apply -f kafkaconfig/zookeeper-svc.yaml"
            sh "kubectl apply -f kafkaconfig/kafka-deploy.yaml"
            sh "kubectl apply -f kafkaconfig/kafka-svc.yaml"
        }
      }
    }
      
      stage('Configuring Curiosity in Kubernetes') {
      steps {
        withKubeConfig( credentialsId: 'jenkins-token-kubernetes', serverUrl: kubernetes_proxy ) {
	          sh "kubectl apply -f appconfig/curiosityms-namespace.yaml"
            sh "kubectl apply -f ./databaseconfig/."
            sh "sleep 30"
            sh "kubectl -n curiosityevents exec -it `kubectl -n curiosityevents get --no-headers=true pods -l app=mysql-db -o custom-columns=:metadata.name` -- mysql -h 127.0.0.1 -u root -pmySQLpword#2023 < ./databaseconfig/create-curiositydb-resources.sql"
            sh 'kubectl -n curiosityevents create secret generic curiosityms-mysql-db-secret --from-literal=SPRING_DATASOURCE_PASSWORD=$MYSQL_CREDENTIALS_PSW --from-literal=SPRING_DATASOURCE_USERNAME=$MYSQL_CREDENTIALS_USR --dry-run=client -o yaml > curiosityms-mysql-db-secret.yaml'
            sh "kubectl apply -f curiosityms-mysql-db-secret.yaml"
            sh "kubectl -n curiosityevents rollout restart deployment/curiosityms-deployment"
            sh "kubectl apply -f ./appconfig/."
        }
      }
    }
  

   

  
  }
  post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: true,
                    deleteDirs: true,
                    disableDeferredWipeout: false,
                    notFailBuild: false,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
        }
    }
}
