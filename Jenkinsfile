pipeline {
    agent any

    stages {
        stage('Deploy Flask App') {
            steps {
                sshagent(['flask-ssh']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no mohancbe5202@34.69.84.254 '
                        set -e

                        echo "Ensuring logs directory exists..."
                        mkdir -p /opt/flask-app/logs
                        chown -R mohancbe5202:mohancbe5202 /opt/flask-app/logs

                        echo "Reloading systemd..."
                        sudo systemctl daemon-reload

                        echo "Restarting Flask service via systemd..."
                        sudo systemctl restart flaskapp

                        echo "Checking service status..."
                        systemctl status flaskapp --no-pager
                    '
                    """
                }
            }
        }
    }
}





