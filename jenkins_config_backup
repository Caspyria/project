pipeline {
    agent any

    environment {
        // Hardcode Docker path known to work on your Mac
        DOCKER_PATH = "/usr/local/bin/docker"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Caspyria/project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "${DOCKER_PATH} build -t my-nginx-image:${BUILD_NUMBER} ."
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                sh '''
                    if [ "$(${DOCKER_PATH} ps -q -f name=my-nginx-container)" ]; then
                        ${DOCKER_PATH} rm -f my-nginx-container
                    fi
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh "${DOCKER_PATH} run -d --name my-nginx-container -p 8081:80 my-nginx-image:${BUILD_NUMBER}"
            }
        }
    }

    post {
        success {
            echo 'Deployed container on port 8081'
        }
        failure {
            echo 'Deployment failed'
        }
    }
}

