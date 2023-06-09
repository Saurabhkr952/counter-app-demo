
# Streamline Your Java Maven Application Deployment with this Ultimate CI/CD Pipeline using Jenkins, Docker, SonarQube, Argo CD, Helm and Kubernetes
![ultimate cicd pipeline](https://user-images.githubusercontent.com/32189783/229286588-d165390a-79ca-4c1f-9a45-956d09fa7deb.png)

## Jenkins configured with Docker as a slave 

![jenkins-slave](https://user-images.githubusercontent.com/32189783/229287151-194fb508-a3db-4430-acd4-34633caff802.png)

## MY-PROJECT CI/CD PIPELINE

<img width="1070" alt="25" src="https://user-images.githubusercontent.com/32189783/229287240-5a86a39e-2d7b-4c01-8680-63f6642ef295.png">



## Here are the step-by-step details:

For Installing Jenkins & Configuring Docker as agent: https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero
 


## Install Required Plugins:

* Docker Pipeline
* Slack Notification
* SonarQube Scanner

## Setting Up SonarQube 

1. Install Docker on your EC2 instance. ( Don't forget to reboot your EC2)
2. Enable inbound rule 9000 in your EC2 security group.
3. Create a directory named "sonarqube" in your home directory.
```
mkdir sh
```
4. Run the following command to start the SonarQube server:
```
sudo docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 -v ~/sonarqube-data:/opt/sonarqube/data sonarqube
```
5. Fetch the SonarQube token and add it to Jenkins credentials as a secret text.
```
If you need help then checkout this video.I've added timestamp : https://youtu.be/KsTMy0920go?t=191
```
6. Add the SonarQube server to Jenkins by navigating to "Manage Jenkins" > "System" > "SonarQube Servers" and entering the server name, server URL, and authentication token.
'

## Setting Up DockerHub
1. Add the DockerHub username and password as secret text in Jenkins credentials.

2. Set the ID same as {docker-hub-repo} in the Jenkinsfile.

<img width="480" alt="docker hub credential" src="https://user-images.githubusercontent.com/32189783/229286168-0eb76be8-2c85-46f7-9410-93379fc61232.png">

## Setting Up GitHub
1. Generate a Personal Access Token (PAT) from your GitHub account at https://github.com/settings/tokens.
2. Add the GitHub username and PAT as secret text in Jenkins credentials.
3. Set the ID same as {github-credentials} in the Jenkinsfile.

## Setting Up Slack
1. Create a Slack account and workspace.
2. Navigate to https://plugins.jenkins.io/slack/ and select the "any" channel from your workspace to get the token.
3. Add the Slack token as secret text in Jenkins credentials.
4. Now go to Dashboard > Manage Jenkins > System and search for Slack and configure it.

<img width="1080" alt="slack" src="https://user-images.githubusercontent.com/32189783/229286202-99e58e70-0909-416f-8df3-6fcb1578729f.png">


<img width="1080" alt="22" src="https://user-images.githubusercontent.com/32189783/229286247-9078b9ad-c8ee-466d-96e9-5794d90fdda5.png">





Congratulations! You have successfully set up Jenkins and Docker for slave configuration.
 
