pipeline {
    agent any

    environment {
        DOCKER_PATH = "/usr/local/bin/docker"
        IMAGE_TAG = "my-nginx-image:${BUILD_NUMBER}"
	OCKER_EXECUTABLE_PATH = '/usr/local/bin/docker'   
        KUBECTL_EXECUTABLE_PATH = '/usr/local/bin/kubectl' 
        MINIKUBE_EXECUTABLE_PATH = '/usr/local/bin/minikube' 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Caspyria/project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "${DOCKER_PATH} build -t ${IMAGE_TAG} ."
            }
        }

        stage('Load Image into Minikube') {
            steps {
                sh "minikube image load ${IMAGE_TAG}"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/nginx-deployment.yaml'
                sh 'kubectl apply -f k8s/nginx-service.yaml'
            }
        }
    }

    post {
        success {
            echo 'Deployed to Kubernetes via Minikube'
        }
        failure {
            echo 'Deployment failed'
        }
    }
}

