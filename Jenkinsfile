pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'angork/desafio9'
        DOCKER_IMAGE_TAG = '1.1'
    }

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'USER_GITHUB', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD')]) {
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '']],
                        submoduleCfg: [],
                        userRemoteConfigs: [[credentialsId: 'USER_GITHUB', url: 'https://github.com/angork35/desafio9.git']]
                    ])
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", '.')
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p 5000:5000 --name my_app ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}'
            }
        }

        stage('Test') {
            steps {
                sh 'docker exec my_app curl http://localhost:5000'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([string(credentialsId: '9cbfd706-ac58-42c6-8896-b663b81eecca', variable: 'DOCKER_TOKEN')]) {
                    script {
                        docker.withRegistry('', 'dockerhub') {
                            dockerImage.push()
                        }
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
