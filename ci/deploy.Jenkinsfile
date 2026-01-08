pipeline {
  agent any

  parameters {
    gitParameter(
      name: 'TAG',
      type: 'PT_TAG',
      defaultValue: '',
      description: 'Tag to deploy',
      sortMode: 'DESCENDING_SMART',
      selectedValue: 'TOP'
    )
    choice(name: 'ENVIRONMENT', choices: ['prod', 'dev'], description: 'Qué entorno desplegar.')
    string(name: 'EXTERNAL_PORT', defaultValue: '3000', description: 'Puerto externo del contenedor.')
    string(name: 'METRICS_PORT', defaultValue: '3001', description: 'Puerto externo de las métricas.')
  }

  environment {
    GIT_USER_NAME = 'Jenkins CI'
    GIT_USER_EMAIL = 'jenkins[bot]@noreply.jenkins.io'

    TF_VAR_environment = "${params.ENVIRONMENT}"
    TF_VAR_api_external_port = "${params.EXTERNAL_PORT}"
    TF_VAR_api_metrics_port = "${params.METRICS_PORT}" 
  }

  stages {
    stage('Checkout') {
      steps {
        sshagent(credentials: ['github']) {
          script {
            if (!params.TAG || params.TAG == '') {
              error "The 'TAG' parameter is mandatory. Please select a valid tag."
            }
            sh """
              git config user.name "${env.GIT_USER_NAME}"
              git config user.email "${env.GIT_USER_EMAIL}"

              git fetch --tags --force
              git checkout ${params.TAG}
            """
          }
        }
      }
    }

    stage('Validate Terraform Params') {
      steps {
        script {
          if (!params.EXTERNAL_PORT?.isInteger() || !params.METRICS_PORT?.isInteger()) {
            error "Ports must be integers. EXTERNAL_PORT=${params.EXTERNAL_PORT}, METRICS_PORT=${params.METRICS_PORT}"
          }
        }
      }
    }

    stage('Prepare Terraform Plan Name') {
      steps {
        script {
          env.TF_HAS_CHANGES = "false"
          env.TFPLAN_TS = sh(script: 'date +%Y%m%d%H%M', returnStdout: true).trim()
          def raw = "tfplan.${params.TAG}-${params.ENVIRONMENT}-${env.TFPLAN_TS}"
          env.TFPLAN_NAME = raw.replaceAll('[^A-Za-z0-9._-]', '_')
        }
      }
    }

    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init -input=false'
        }
      }
    }

    stage('Terraform Validate'){
      steps {
        dir('terraform') {
          sh '''
            terraform fmt -check
            terraform validate
          '''
        }
      }
    }

    stage('Confirm New Deployment') {
      steps {
        input message: "Deploy tag ${params.TAG}? Previous resources are going to be deleted.", ok: 'Deploy'
      }
    }

    stage('Terraform Destroy') {
      steps {
        dir('terraform') {
          sh 'terraform destroy -auto-approve'
        }
      }
    }

    stage('Clean Docker Images') {
      steps {
        sh 'docker image prune -a -f'
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh "terraform plan -input=false -out=${env.TFPLAN_NAME}"
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          sh "terraform apply -auto-approve -input=false ${env.TFPLAN_NAME}"
        }
      }
    }
  }

  post {
    success {
      echo """
        ==========================================
        DEPLOY SUCCESSFUL
        ==========================================
        Tag: ${params.TAG}
        Duration: ${currentBuild.durationString}
        ==========================================
      """
    }
    failure {
      echo """
        ==========================================
        DEPLOY FAILED
        ==========================================
        Tag: ${params.TAG}
        Duration: ${currentBuild.durationString}
        ==========================================
      """
    }
  }
}