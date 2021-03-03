pipeline {
    agent {
        kubernetes {
            cloud 'kubernetes'
            inheritFrom 'python'
            namespace 'jenkins'
        }
    }
    stages {
        stage('Build') {
            steps {
                container('python') {
                    sh "hostname"
                    sh "cat /etc/*-release"
                    sh "uname -a"
                    sh "python --version"
                }
            }
        }
    }
}