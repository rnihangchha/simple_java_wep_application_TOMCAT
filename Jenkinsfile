pipeline {
    agent any
    environment {
        DOCKER_HUB_REPO = "hehehangchha"
    }
  
    stages{
        stage("Git checkout") {
            steps{
                echo "Cloning repo..."
                git url: "https://github.com/rnihangchha/simple_java_wep_application_TOMCAT.git ", branch:"main"
            }
        }
        stage ("Build") {
            steps{
                sh "mvn clean package -DskipTests"
            }    
        }
        stage ("Unit test"){
            steps{
                sh "mvn test"
            }
        }
        stage ("Code quality"){
            steps {
                echo "Sonar cube"
            }
            
        }
        stage ("Docker build") {
            steps{
                echo "Building docker image"
                sh "docker buildx build -t ${DOCKER_HUB_REPO}/myjava-app:${BUILD_ID} ."
            }
           
        }
        stage ("Image push to docker hub") {
            steps {
            withCredentials([usernamePassword(credentialsId: '0f7da4fb-fbe5-4c42-8581-ef827bc636b2', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh """
                    echo ${password} | docker login -u ${username} --password-stdin
                    docker push ${DOCKER_HUB_REPO}/myjava-app:${BUILD_ID}
                    """
                }
            }
        }


    }
}