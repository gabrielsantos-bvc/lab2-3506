pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_REGION            = 'us-east-1'
        DOCKER_IMAGE_NAME     = 'gabrielsantos-3506-final-project'
        EC2_INSTANCE_IP       = 'ec2-34-228-157-235.compute-1.amazonaws.com'
        SSH_USER              = 'ubuntu'
        SSH_KEY               = credentials('ssh-key')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t $DOCKER_IMAGE_NAME ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to a registry
                    withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_HUB_CREDENTIALS')]) {
                        sh "docker login -u gabrielsantosbvc -p $DOCKER_HUB_CREDENTIALS"
                        sh "docker push $DOCKER_IMAGE_NAME"
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    // Copy Docker Compose file and SSH key to EC2 instance
                    sshagent(credentials: ['SSH_KEY']) {
                        sh "scp -i $SSH_KEY docker-compose.yml $SSH_USER@$EC2_INSTANCE_IP:~/"
                    }

                    // SSH into EC2 instance and start the Docker containers
                    sshagent(credentials: ['SSH_KEY']) {
                        sh "ssh -i $SSH_KEY $SSH_USER@$EC2_INSTANCE_IP 'docker-compose -f ~/docker-compose.yml up -d'"
                    }
                }
            }
        }
    }
}
