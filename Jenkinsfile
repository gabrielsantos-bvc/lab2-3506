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
        sh "docker build -t gabrielsantosbvc/$DOCKER_IMAGE_NAME:latest ."
      }
    }
  }

  stage('Push Docker Image') {
    steps {
      // Push the Docker image to a registry
      withCredentials([string(credentialsId: 'docker-hub-credentials', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
        sh "docker push gabrielsantosbvc/$DOCKER_IMAGE_NAME:latest"
      }
    }
  }

  stage('Deploy to EC2') {
    steps {
      // Copy Docker Compose file and SSH key to EC2 instance
      sshagent(credentials: ['SSH_KEY']) {
        sh "scp -i $SSH_KEY docker-compose.yml $SSH_USER@$EC2_INSTANCE_IP:~/"
      }

      //SSH into EC2 instance and start the Docker containers
      sshagent(credentials: ['SSH_KEY']) {
        sh "ssh -i $SSH_KEY $SSH_USER@$EC2_INSTANCE_IP 'docker-compose -f ~/docker-compose.yml up -d'"
      }
    }
  }
}
