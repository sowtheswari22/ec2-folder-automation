pipeline {
    agent any

    environment {
        APP_SERVER_IP      = "136.114.250.47"
        APP_USER           = "mohancbe5202"
        APP_DIR            = "/opt/ec2-folder-automation"
        SERVICE_NAME       = "ec2-folder-automation"
        GIT_BRANCH         = "main"
    }

    stages {
        stage('Deploy to Application Server') {
            steps {
                sshagent(['app-server-ssh']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${APP_USER}@${APP_SERVER_IP} '
                        set -e

                        echo "📂 Moving to app directory"
                        cd ${APP_DIR}

                        echo "📥 Pulling latest code"
                        git pull origin ${GIT_BRANCH}

                        echo "🔄 Reloading systemd"
                        sudo systemctl daemon-reload

                        echo "🚀 Restarting service"
                        sudo systemctl restart ${SERVICE_NAME}

                        echo "✅ Verifying service status"
                        systemctl is-active ${SERVICE_NAME}
                    '
                    """
                }
            }
        }
    }
}



