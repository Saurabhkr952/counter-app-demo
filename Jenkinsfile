pipeline {
    agent any

    stages {
      //  stage("Checkout") {
      //     steps {
      //        git branch: 'main', url: 'https://github.com/Saurabhkr952/counter-app-demo'
       //    }
      //  }
        stage("Building Application") {
            steps {
                sh 'mvn clean install'
            }
            
        }
        stage("Unit & Integration Testing") {
            steps {
                sh 'mvn test'
                sh 'mvn verify -DskipUnitTests'
            }
        }
        stage("Static Code Analysis(SonarQube)") {
            steps {
                withSonarQubeEnv(installationName: 'sonar-api') {
                        sh 'mvn clean package sonar:sonar'
                  }
             }
            post {
            failure {
            slackSend(channel: "#general", message: "Build failed in stage ${env.STAGE_NAME}\nMore info at: ${env.BUILD_URL}")
        }
        }
        stage("Build Docker Image") {
            steps {
                echo 'Building Docker Image'
                sh "docker build -t saurabhkr952/counter-demo-app:$BUILD_NUMBER ."
            }
        }
        stage("Pushing Artifact to Dockerhub") {
              steps {
                  echo 'deploying the application...'
                  withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                     sh "echo $PASS | docker login -u $USER --password-stdin"
                     sh "docker push saurabhkr952/counter-demo-app:$BUILD_NUMBER"
                  }
              }
        }
        // stage("Pushing Artifact to Dockerhub") {
        //     steps {
        //         echo 'deploying the application...'
        //         withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        //             sh "echo $PASS | docker login -u $USER --password-stdin"
        //             sh "docker push saurabhkr952/my-portfolio:$IMAGE_NAME"
        //     }
        // }
        // stage("Update k8s manifest Repo") {
        //     steps {
        //         script {
        //             gv.update_k8s_manifest()
        //         }
        //     }
        // }
    }
        post {
            failure {
            slackSend(channel: "#general", message: "Build failed in stage ${env.STAGE_NAME}\nMore info at: ${env.BUILD_URL}")
        }
       
            success {
            slackSend channel: "#general", message:  "Build Status: ${currentBuild.currentResult} \n${env.JOB_NAME} ${env.BUILD_NUMBER} \nMore info at: ${env.BUILD_URL}" 
            }
}
}
