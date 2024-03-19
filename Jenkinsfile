  pipeline {
    agent any
    environment {     
    DOCKERHUB_CREDENTIALS=credentials('dockerhubcreds')     
  }
    stages {
        stage("Git Checkout"){           
            agent { label 'slave' }
            steps{                
	          git url: 'https://github.com/Shfarrukhb/demo-app.git', branch: 'main'                 
	          echo 'Git Checkout Completed'            
            }        
        }
        stage('Build') {
            agent { label 'slave' }
            steps {
                echo 'Building...'
                sh 'docker build . -t shfarrukhb/demo'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push shfarrukhb/demo'
            }
        }
        stage('helm deploy') {
            agent { label 'slave' }
            steps { 
                echo 'Deploying helm...'
                sh 'helm upgrade --install app helm-deploy -f helm-deploy/values.yaml'
                sh 'helm list'
                sh 'microk8s kubectl get pods'
                sh 'microk8s kubectl get svc'
                sh 'docker logout'
            }
        }
   }
}
