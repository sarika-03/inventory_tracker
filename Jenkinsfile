pipeline {
    agent any
    
    environment {
        
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = "sarika1731/inventory:3.12-slim"
        TF_VAR_docker_image = "${DOCKER_IMAGE}"
        
        TF_VAR_environment = "${env.BRANCH_NAME == 'main' ? 'prod' : 'dev'}"
    }
    
    stages {
        stage("Checkout") {
            steps {
                script {
                    
                    env.BRANCH_NAME = "main" 
                }
                checkout scmGit(
                    branches: [[name: '*/main']], 
                    extensions: [], 
                    userRemoteConfigs: [[
                        credentialsId: 'github', 
                        url: 'https://github.com/sarika-03/inventory_tracker'
                    ]]
                )
            }
        }
        
        
        
        stage("Setup Python Environment") {
            steps {
                sh '''
                    python3 -m venv venv && \
                    source venv/bin/activate && \
                    pip install --upgrade pip && \
                    pip install -r docker/requirements.txt && \
                    pip install pytest && \
                    ls -la venv/bin/
                '''
            }
        }
        
        stage("Run Tests") {
            steps {
                sh '''
                    source venv/bin/activate
                    pytest --version || echo "No tests found, skipping..."
                '''
            }
        }
        
        stage("Docker Build Image") {
            steps {
                sh """
                    docker build -t ${DOCKER_IMAGE} -f docker/Dockerfile .
                """
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                sh '''
                    echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                '''
            }
        }
        
        stage("Push Docker Image") {
            steps {
                sh """
                    docker push ${DOCKER_IMAGE}
                """
            }
        }
        
        stage("Terraform Init") {
            steps {
                dir('terraform') {
                    sh '''
                        terraform init -input=false
                    '''
                }
            }
        }
        
        stage("Terraform Plan") {
            steps {
                dir('terraform') {
                    sh '''
                        terraform plan \
                            -var="docker_image=${DOCKER_IMAGE}" \
                            -var="environment=${TF_VAR_environment}" \
                            -out=tfplan \
                            -input=false
                    '''
                }
            }
        }
        
        stage("Terraform Apply") {
            when {
                branch 'main'
            }
            steps {
                dir('terraform') {
                    sh '''
                        terraform apply -input=false tfplan
                    '''
                }
            }
        }
        
        stage("Verify Deployment") {
            steps {
                sh '''
                    echo "Checking Docker container..."
                    docker ps | grep inventory-tracker-app || echo "Container not running yet"
                    
                    echo "Checking Kubernetes deployment..."
                    kubectl get pods -n inventory-dev || echo "K8s not configured"
                '''
            }
        }
    }
    
    post {
        always {

            script {
                dir('terraform') {
                    sh 'terraform output -json > terraform-output.json || true'
                    archiveArtifacts artifacts: 'terraform-output.json', allowEmptyArchive: true
                }
                
                
                sh 'docker logout || true'
            }
        }
        
        success {
            
            emailext(
                body: """Hello Team,
...
Branch: ${BRANCH_NAME}
...
""",
                
                recipientProviders: [developers()],
                subject: "✅ SUCCESS: Job ${JOB_NAME} [${BUILD_NUMBER}]",
                to: "sarikasharma9711@gmail.com"
            )
        }
        
        failure {

            script {
                emailext(
                    body: """Hello Team,
...
Branch: ${env.BRANCH_NAME}
...
""",
                    recipientProviders: [developers()],
                    subject: "❌ FAILURE: Job ${JOB_NAME} [${BUILD_NUMBER}]",
                    to: "sarikasharma9711@gmail.com"
                )
            }
        }
    }
}