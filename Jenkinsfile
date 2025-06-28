pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Pull latest from your repo
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image named "my-nginx-image"
                    sh 'docker build --no-cache -t my-nginx-image:latest .'
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove old container if exists
                    sh '''
                    if [ $(docker ps -q -f name=my-nginx-container) ]; then
                        docker stop my-nginx-container
                        docker rm my-nginx-container
                    fi
                    '''
                    // Run container mapping host port 8081 to container port 80
                    sh 'docker run -d --name my-nginx-container -p 8081:80 my-nginx-image:latest'
                }
            }
        }
    }
    post {
        success {
            echo 'Deployment successful! Open http://localhost:8081 in your browser.'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Caspyria/project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t my-nginx-web .'
                }
            }
        }

        stage('Stop Existing Container') {
            steps {
                script {
                    sh '''
                    docker stop nginx-web || true
                    docker rm nginx-web || true
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run -d -p 8080:80 --name nginx-web my-nginx-web'
                }
            }
        }
    }
}

