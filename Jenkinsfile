pipeline {
    agent {
        node {
            label 'node'
            }
    }

    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    // Installe les dépendances npm
                    sh 'npm install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Exécute les tests Jest
                    sh 'npm test'
                }
            }
        }
    }

    post {
        always {
            // Actions à effectuer après chaque build, peu importe le résultat
            archiveArtifacts artifacts: 'path/to/artifacts/**/*', allowEmptyArchive: true
        }

        success {
            // Actions à effectuer en cas de succès
            echo 'Build and tests succeeded!'
        }

        failure {
            // Actions à effectuer en cas d'échec
            echo 'Build or tests failed!'
        }

        cleanup {
            // Actions à effectuer pour nettoyer, si nécessaire
            cleanWs()
        }
    }
}