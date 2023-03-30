pipeline {
    agent any

    stages {
      //  stage("Checkout") {
      //     steps {
      //        git branch: 'main', url: 'https://github.com/Saurabhkr952/counter-app-demo'
       //    }
      //  }
        stage("Compiling Application") {
            steps {
                sh 'mv clean install'
            }
        }
        stage("Unit & Integration Testing") {
            steps {
                sh 'mvn test'
                sh 'mvn verify -DskipUnitTests'
            }
              post {
            failure {
            slackSend(channel: "#general", color: '#D70040', message: "Build failed in stage ${env.STAGE_NAME}\nMore info at: ${env.BUILD_URL}")
            }
              }
        }
      //  stage("Static Code Analysis(SonarQube)") {
      //      steps {
      //          withSonarQubeEnv(installationName: 'sonar-api') {
      //                  sh 'mvn clean package sonar:sonar'
      //            }
      //       }
      //        post {
      //      failure {
      //      slackSend(channel: "#general", color: '#D70040', message: "Build failed in stage ${env.STAGE_NAME}\nMore info at: ${env.BUILD_URL}")
      //      }
      //        }
      //  }
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
          
            success {
            slackSend channel: "#general", color: '#00ff00', message:  "Build Status: ${currentBuild.currentResult} \n${env.JOB_NAME} ${env.BUILD_NUMBER} \nMore info at: ${env.BUILD_URL}" 
            }
            failure {
            slackSend channel: "#general", color: '#D70040', message:  "Build Status: ${currentBuild.currentResult} \n${env.JOB_NAME} ${env.BUILD_NUMBER} \nMore info at: ${env.BUILD_URL}" 
            }
}
}
