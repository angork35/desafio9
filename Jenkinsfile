pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "angork/desafio9"
        IMAGE_TAG = "1.0"
    }

    stages {
        stage('Build') {
            steps {
                sh "docker build -t $DOCKER_IMAGE:$IMAGE_TAG ."
            }
        }

        stage('Run Container') {
            steps {
                sh "docker run -d -p 5000:5000 --name my_app $DOCKER_IMAGE:$IMAGE_TAG"
            }
        }

        stage('Test') {
            steps {
                sh "docker exec my_app curl http://localhost:5000"
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                }
                sh "docker tag $DOCKER_IMAGE:$IMAGE_TAG $DOCKER_IMAGE:$IMAGE_TAG"
                sh "docker push $DOCKER_IMAGE:$IMAGE_TAG"
            }
        }
    }
}
