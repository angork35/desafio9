pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "angork/desafio9"
        IMAGE_TAG = "1.1" // Recuerda actualizar la etiqueta a medida que hagas cambios en el Dockerfile
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construir la imagen Docker con la etiqueta adecuada
                    sh "docker build -t $DOCKER_IMAGE:$IMAGE_TAG ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Ejecutar el contenedor a partir de la imagen construida
                    sh "docker run -d -p 5000:5000 --name my_app $DOCKER_IMAGE:$IMAGE_TAG"
                }
            }
        }

        stage('Test') {
            steps {
                // Esperar unos segundos para que la aplicación se inicie completamente
                sleep 10

                // Ejecutar la prueba con curl contra la aplicación Flask en el contenedor
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

    post {
        always {
            // Detener y eliminar el contenedor después de terminar
            sh "docker stop my_app || true"
            sh "docker rm my_app || true"
        }
    }
}

        }
    }
}
