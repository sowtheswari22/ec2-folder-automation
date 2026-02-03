pipeline {
    agent any

    stages {

        stage('Install Dependencies') {
            steps {
                sshagent(['flask-ssh']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no mohancbe5202@34.69.84.254 << 'EOF'
                      cd /opt/flask-app
                      git pull origin main
                      source venv/bin/activate
                      pip install -r requirements.txt
                    EOF
                    '''
                }
            }
        }

        stage('Deploy Flask App') {
            steps {
                sshagent(['flask-ssh']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no mohancbe5202@34.69.84.254 << 'EOF'
                      cd /opt/flask-app
                      source venv/bin/activate
                      pkill -f gunicorn || true
                      gunicorn app:app -b 0.0.0.0:5000 --daemon
                    EOF
                    '''
                }
            }
        }
    }
}


