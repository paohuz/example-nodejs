pipeline {
    agent any
    environment {
        APP_GIT_URL = "https://github.com/pornpasok/example-nodejs.git"
        APP_TAG = "latest"
        DEV_PROJECT = "development"
        NEXUS_SERVER = ""
    }
    
    stages {
        stage('Clean') {
            steps {
                echo 'Clean Workspace'
                sh '''
                    rm -rf *
                '''
            }
        }

        stage('SCM') {
            steps {
                echo 'Pull code from SCM'
                git(
                    url: "${APP_GIT_URL}",
                    //credentialsId: 'github-cicd',
                    branch: "main"
                )
            }
        }

        stage('Deploy to Dev ENV') {
            steps {
                echo 'Deploy to Dev ENV'
                sh '''
                    docker-compose up --build -d
                '''

            }
        }
        
        stage('Scale App') {
            steps {
                echo 'Scale App'
                sh '''
                    docker-compose scale hello1=2 hello2=2
                '''
            }
        }

        stage('Check Hello1 App') {
            steps {
                echo 'Check Hello1 App'
                sh '''
                    sleep 30
                    STATUSCODE=$(curl -s -o /dev/null -I -w "%{http_code}" http://localhost/hello1)
                    if test $STATUSCODE -ne 200; then echo ERROR:$STATUSCODE && exit 1; else echo SUCCESS; fi;
                '''
            }
        }

        stage('Check Hello2 App') {
            steps {
                echo 'Check Hello2 App'
                sh '''
                    sleep 30
                    STATUSCODE=$(curl -s -o /dev/null -I -w "%{http_code}" http://localhost/hello2)
                    if test $STATUSCODE -ne 200; then echo ERROR:$STATUSCODE && exit 1; else echo SUCCESS; fi;
                '''
            }
        }
    }
}