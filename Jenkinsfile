pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-demo"
        CONTAINER_NAME = "flask-demo-container"
        PORT = "5000"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo '📦 Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/ramanjipgl-hub/sampleapp.git'
            }
        }

        stage('Cleanup Old Containers & Images') {
            steps {
                echo '🧹 Cleaning up old containers and images...'
                bat '''
                for /f "tokens=*" %%i in ('docker ps -aq') do docker rm -f %%i
                for /f "tokens=*" %%i in ('docker images -q') do docker rmi -f %%i
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                bat 'docker build -t %IMAGE_NAME%:latest .'
            }
        }

        stage('Run Container') {
            steps {
                echo '🚀 Running container...'
                bat '''
                docker rm -f %CONTAINER_NAME% || exit 0
                docker run -d --name %CONTAINER_NAME% -p %PORT%:5000 %IMAGE_NAME%:latest
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo '🔍 Verifying container is running...'
                bat 'docker ps | findstr %CONTAINER_NAME%'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check logs.'
        }
    }
}
