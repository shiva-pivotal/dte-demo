pipeline {
    agent any
    stages {
        stage('Deploy Dev') {
            environment {
                PCF_CREDS = credentials('pcfpez-student-1-creds')
            }
            steps {
                sh 'cf login --skip-ssl-validation -a https://api.run.haas-81.pez.pivotal.io -u ${PCF_CREDS_USR} -p ${PCF_CREDS_PSW} -o student-1 -s student-1'
                sh 'cf push'
            }
        }
        stage('Smoke Test') {
            steps {
                sh '''
                    echo 'smoke test'
                '''
            }
        }
    }
    post {
        always {
          step([$class: 'ClaimPublisher'])
        }
    }
}
