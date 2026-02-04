stage('Deploy Flask App') {
    steps {
        sshagent(['flask-ssh']) {
            sh """
            ssh -o StrictHostKeyChecking=no mohancbe5202@34.69.84.254 '
                set -e
                cd /opt/jenkins/flask-app
                source venv/bin/activate

                # Stop existing gunicorn processes
                if pgrep -f gunicorn > /dev/null; then
                    echo "Stopping existing gunicorn..."
                    pkill -f gunicorn
                fi

                echo "Starting gunicorn..."
                gunicorn app:app -b 0.0.0.0:5000 --daemon \
                    --access-logfile logs/access.log \
                    --error-logfile logs/error.log
            '
            """
        }
    }
}



