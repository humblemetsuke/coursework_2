pipeline {
   agent any

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
