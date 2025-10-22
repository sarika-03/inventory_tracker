pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'sarika1731/inventory:3.12-slim'
    }
    
    stages {
        stage('Build') {
            steps {
                // Checkout code from Git
                checkout scm
                
                // Build Docker image
                sh 'docker build -t $DOCKER_IMAGE -f docker/Dockerfile .'
            }
        }
        
        stage('Test') {
            steps {
                // Run tests if you have any
                sh '''
                    docker run -d --name test-container $DOCKER_IMAGE
                    docker stop test-container
                    docker rm test-container
                '''
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Apply Kubernetes configurations
                sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                '''
            }
        }
    }
}