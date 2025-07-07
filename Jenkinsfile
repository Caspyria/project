pipeline {
    agent any

    environment {
        // Adjust path to where your Docker is (Apple Silicon vs Intel)
        PATH = "/opt/homebrew/bin:/usr/local/bin:/bin:/usr/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Caspyria/project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t my-nginx-image:${BUILD_NUMBER} ."
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                sh '''
                    if [ "$(docker ps -q -f name=my-nginx-container)" ]; then
                        docker rm -f my-nginx-container
                    fi
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh "docker run -d --name my-nginx-container -p 8081:80 my-nginx-image:${BUILD_NUMBER}"
            }
        }
    }

    post {
        success {
            echo 'Deployed container on port 8081'
            // macOS only; skip this if you're using Linux
            sh 'which open && open http://localhost:8081 || echo "Open skipped"'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}

