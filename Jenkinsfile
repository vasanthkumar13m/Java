pipeline {
    agent any

    tools {
        maven 'maven'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'feature/branch',
                    credentialsId: 'github',
                    url: 'https://github.com/vasanthkumar13m/Java.git'
            }
        }

        stage('Build') {
            steps {
                dir('java-list-map') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                dir('java-list-map') {
                    withSonarQubeEnv('Sonarqube') {
                        withCredentials([string(credentialsId: 'SonarQube', variable: 'SONAR_TOKEN')]) {
                            sh '''
                                mvn sonar:sonar \
                                -Dsonar.token=$SONAR_TOKEN
                            '''
                        }
                    }
                }
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'java-list-map/target/*.jar', fingerprint: true
            }
        }

        stage('Deploy To EC2') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'ec2-instance',
                            transfers: [
                                sshTransfer(
                                    sourceFiles: 'java-list-map/target/*.jar',
                                    removePrefix: 'java-list-map/target',
                                    remoteDirectory: '/app'
                                )
                            ]
                        )
                    ]
                )
            }
        }
    }

    post {
        success {
            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Successful

Job Name : ${env.JOB_NAME}
Build No  : ${env.BUILD_NUMBER}

Build URL:
${env.BUILD_URL}

JAR File Created Successfully.
SonarQube Analysis Completed.
""",
                to: 'somisettyvasanthkumar@gmail.com'
            )
        }

        failure {
            emailext(
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Failed

Job Name : ${env.JOB_NAME}
Build No  : ${env.BUILD_NUMBER}

Build URL:
${env.BUILD_URL}

Please check the Jenkins console logs.
""",
                to: 'somisettyvasanthkumar@gmail.com'
            )
        }
    }
}