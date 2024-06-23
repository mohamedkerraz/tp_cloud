pipeline {
    agent {
        node {
            label 'node'
        }
    }

    stages {
        stage('Change to Backend Directory') {
            steps {
                // Change le répertoire de travail vers ./backend
                dir('backend') {
                    script {
                        // Exécute un script vide pour changer le répertoire
                        echo 'Changing working directory to ./backend'
                    }
                }
            }
        }
        
        stage('Install Dependencies') {
            steps {
                dir('backend') {
                    sh 'npm install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    dir('backend') {
                        sh 'npm test'
                    }
                }
            }
        }
    }

    post {
        always {
            // Actions à effectuer après chaque build, peu importe le résultat
            archiveArtifacts artifacts: './artifacts', allowEmptyArchive: true
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
