pipeline {
    agent any

    stages {

        stage('Install Dependencies') {
            steps {
                sshagent(['flask-ssh']) {
                    sh '''
                    ssh mohancbe5202@APPLICATION_SERVER_IP << EOF
                      cd /opt/flask-app
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
                    ssh mohancbe5202@APPLICATION_SERVER_IP << EOF
                      cd /opt/flask-app
                      source venv/bin/activate
                      pkill gunicorn || true
                      gunicorn app:app -b 0.0.0.0:5000 --daemon
                    EOF
                    '''
                }
            }
        }

    }
}
