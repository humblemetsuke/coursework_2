pipeline {
         agent any
         stages {
                 stage('Checkout') {
                 steps {
                     echo 'Retrieving Jenkinsfile from the github repository.'
                   checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'LocalBranch', localBranch: 'dummy']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/humblemetsuke/coursework_2']]])
                 }
                 }
                  
        stage('SonarQube') {
    environment {
        scannerHome = tool 'SonarQube'
    }
    steps {
        withSonarQubeEnv('SonarQube') {
            sh "${scannerHome}/bin/sonar-scanner"
        }
        timeout(time: 1, unit: 'HOURS') {
            waitForQualityGate abortPipeline: true
        }
    }
}

stage ('build docker image') {

steps {
echo 'Beginning to build the docker image.'

script {

docker.build("coursework_2")

         }
}

}

stage ('push docker image to DockerHub') {

steps {
echo 'Beginning to push the built docker image to Dockerhub.'

script {

withDockerRegistry(credentialsId: 'e1984af9-1751-4825-883a-9194875c8f89', url: '') {
         docker.push("${env.BUILD_NUMBER}")
docker.push("coursework_2")
         }
}

}

}
}
}
