pipeline {
    agent any

    stages {
        stage('Deploy to Application Server') {
            steps {
                sshagent(['app-server-ssh']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no mohancbe5202@<APPLICATION_SERVER_PRIVATE_IP> '
                        cd /opt/ec2-folder-automation &&
                        git pull origin main &&
                        sudo systemctl restart ec2-folder-automation
                    '
                    """
                }
            }
        }
    }
}




