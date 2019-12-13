pipeline {
  environment {
    registry = "humblemetsuke/coursework_2"
    registryCredential = 'e1984af9-1751-4825-883a-9194875c8f89'
    dockerImage = ''
  }
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

    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
      
      stages {
      stage('Deploy VM') {
         steps {
            ansiblePlaybook playbook: 'roles/master/tasks/aws.yml'
         }
      }
      stage('Deploy Kubernetes cluster') {
         steps {
             ansiblePlaybook playbook: 'roles/master/tasks/aws.yml'
            //ansiblePlaybook credentialsId: 'ansible.pem', inventory: 'inventory/k8s', playbook: 'k8sdeploy.yml'
         }
      }
      stage('Deploy App') {
         steps {
            git 'git_url_config'
               kubernetesDeploy(
                    kubeconfigId: 'k8s-default-namespace-config-id',
                    configs: 'pod.yml',
                    enableConfigSubstitution: true
                    )
         }
      }
      stage('Deploy Service') {
         steps {
              git 'git_url_config'
               kubernetesDeploy(
                    kubeconfigId: 'k8s-default-namespace-config-id',
                    configs: 'Deployment.yml',
                    enableConfigSubstitution: true
                    )
         }
      }
      stage('Rolling update') {
         steps {
            git 'git_url_config_v2'
               kubernetesDeploy(
                    kubeconfigId: 'k8s-default-namespace-config-id',
                    configs: 'Deployment.yml',
                    enableConfigSubstitution: true
                    )
    }
  }
}
    }
