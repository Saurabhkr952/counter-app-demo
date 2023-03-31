pipeline {
    agent any

    stages {
        stage("Compiling Application") {
            steps {
                sh 'mvn clean install'
            }
        }
        stage("Unit & Integration Testing") {
            steps {
                sh 'mvn test'
                sh 'mvn verify -DskipUnitTests'
            }
              post {
            failure {
            slackSend(channel: "#general", color: '#D70040', message: "Build failed in stage ${env.STAGE_NAME}")
            }
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
            slackSend(channel: "#general", color: '#D70040', message: "Build failed in stage ${env.STAGE_NAME}")
            }
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
      
         stage("Update k8s manifest Repo") {
             steps {
                 echo "pushing updated manifest to repository"
                   withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'password', usernameVariable: 'username')]) {
                      sh "sed -i 's+saurabhkr952/counter-demo-app:.*+saurabhkr952/counter-demo-app:${{BUILD_NUMBER}}+g' templates/demo-counter-app.yaml"
                      sh "git add -A"
                      sh "git commit -m 'Updated image tag | Image Version=$BUILD_NUMBER'"
                      sh "git remote -v"
                      sh "git push https://$password@github.com/Saurabhkr952/counter-demo-app-manifest-Helm.git HEAD:main"
             }
         }
    }
        post {
          
            success {
            slackSend channel: "#general", color: '#7FFFD4', message:  "Build Status: ${currentBuild.currentResult} \n${env.JOB_NAME} ${env.BUILD_NUMBER} \nMore info at: ${env.BUILD_URL}" 
            }
            failure {
            slackSend channel: "#general", color: '#D70040', message:  "Build Status: ${currentBuild.currentResult} \n${env.JOB_NAME} ${env.BUILD_NUMBER} \nMore info at: ${env.BUILD_URL}" 
            }
}
}
