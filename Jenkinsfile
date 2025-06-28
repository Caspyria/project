pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build --no-cache -t my-nginx-image:latest .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                if [ $(docker ps -q -f name=my-nginx-container) ]; then
                    docker stop my-nginx-container
                    docker rm my-nginx-container
                fi
                docker run -d --name my-nginx-container -p 8081:80 my-nginx-image:latest
                '''
            }
        }

        stage('Open Browser') {
            steps {
                script {
                    // This runs on the Jenkins agent/machine
                    // macOS example: open URL in default browser
                    sh 'open http://localhost:8081'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful! Your site should be open at http://localhost:8081'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}

