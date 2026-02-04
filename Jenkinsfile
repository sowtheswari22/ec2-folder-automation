pipeline {
    agent any

    stages {
        stage('Deploy Flask App') {
            steps {
                sshagent(['flask-ssh']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no mohancbe5202@34.69.84.254 '
                        set -e

                        echo "Pulling latest code from GitHub..."
                        cd /opt/flask-app
                        git pull origin main

                        echo "Ensuring logs directory exists..."
                        mkdir -p logs
                        chown -R mohancbe5202:mohancbe5202 logs

                        echo "Reloading systemd..."
                        sudo systemctl daemon-reload

                        echo "Restarting Flask service..."
                        sudo systemctl restart flaskapp

                        echo "Checking service status..."
                        systemctl is-active flaskapp
                    '
                    """
                }
            }
        }
    }
}




