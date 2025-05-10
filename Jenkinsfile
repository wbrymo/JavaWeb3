pipeline {
    agent any

    environment {
        IMAGE_NAME = 'wbrymo/java-webappcal'
    }

    stages {
        stage('Clone Repo') {
            steps {
                sh '''
                    echo "🧹 Cleaning up existing folder if any..."
                    rm -rf JavaWeb3 || echo "Nothing to delete"
                    echo "📥 Cloning repository..."
                    git clone https://github.com/wbrymo/JavaWeb3.git JavaWeb3
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('JavaWeb3') {
                    script {
                        def app = docker.build("${IMAGE_NAME}")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        docker.image("${IMAGE_NAME}").push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            echo "🧼 Cleaning up Jenkins workspace..."
            cleanWs()
        }
    }
}
