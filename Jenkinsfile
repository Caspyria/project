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

