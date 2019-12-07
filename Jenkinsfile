pipeline {
         agent any
         stages {
                 stage('Checkout') {
                 steps {
                     echo 'Retrieving Jenkinsfile from the github repository.'
                          git 'https://github.com/humblemetsuke/coursework_2'
                 }
                 }
                  
                  post {

        always {

            echo 'Stage has completed!'

          

        }

        success {

            echo 'I succeeded!'

        }

        unstable {

            echo 'I am unstable :/'

        }

        failure {

            echo 'I failed :('

        }

        changed {

            echo 'Things are different...'

        }

    }    
                  
                  
                  
                  
                  
                  
                  
                  
                  
                 stage('Two') {
                 steps {
                    input('Do you want to proceed?')
                 }
                 }
                 stage('Three') {
                 when {
                       not {
                            branch "master"
                       }
                 }
                 steps {
                       echo "Hello"
                 }
                 }
                 stage('Four') {
                 parallel { 
                            stage('Unit Test') {
                           steps {
                                echo "Running the unit test..."
                           }
                           }
                            stage('Integration test') {
                              agent {
                                    docker {
                                            reuseNode true
                                            image 'ubuntu'
                                           }
                                    }
                              steps {
                                echo "Running the integration test..."
                              }
                           }
                           }
                           }
              }
}
