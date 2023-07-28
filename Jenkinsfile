pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'angork/desafio9'
        DOCKER_IMAGE_TAG = '1.1'
        DOCKERHUB_CREDENTIALS = 'USER_DOCKERHUB' // Debe coincidir con el ID de las credenciales en Jenkins
    }

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                // ... (resto del código para checkout de Git)
            }
        }

        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", '.')
                }
            }
        }

        // ... (resto del código para las etapas Run Container y Test)

        stage('Push to DockerHub') {
            steps {
                script {
                    // Tagueo de la imagen con la etiqueta correcta para DockerHub
                    bat "docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} icarrera93/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    // Inicio de sesión en DockerHub con las credenciales
                    withDockerRegistry(credentialsId: "${DOCKERHUB_CREDENTIALS}", url: "https://index.docker.io/v1/") {
                        // Push de la imagen tagueada a DockerHub
                        bat "docker push icarrera93/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker stop my_app || true && docker rm my_app || true'
        }
    }
}
