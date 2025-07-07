pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Caspyria/project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("my-nginx-image:alpine")
                }
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                sh '''
                    if [ $(docker ps -q -f name=my-nginx-container) ]; then
                        docker rm -f my-nginx-container
                    fi
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d --name my-nginx-container -p 8081:80 my-nginx-image:${BUILD_NUMBER}'
            }
        }
    }

    post {
        success {
            echo 'Deployed container on port 8081'
            sh 'open http://localhost:8081' // macOS only
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}

