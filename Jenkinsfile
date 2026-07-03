pipeline {
    agent any

    tools {
        maven 'maven'
    }

    stages {
        stage('Checkout'){
            steps {
                git branch: 'feature/branch', credentialsId: 'github', url: 'https://github.com/vasanthkumar13m/Java.git' 
            }
        }
        stage('Build') {
            steps {
                dir('jackson-json-java') {
                    sh 'mvn clean package'
                }
            }
        }   
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'jackson-json-java/target/*.jar', fingerprint: true
            }
        }
        stage('Deploy To EC2') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ec2-instance', transfers: [sshTransfer(sourceFiles: 'jackson-json-java/target/*.jar', removePrefix: 'jackson-json-java/target', remoteDirectory:'/app')])])
            }
        }
    }
}
