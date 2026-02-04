Flask CI/CD Project Documentation
1. Project Overview

This project demonstrates a complete CI/CD pipeline for a Flask application using GitHub, Jenkins, and Gunicorn with Python virtual environments.

The goal is:

Push code to GitHub

Jenkins automatically pulls the code

Jenkins deploys it to an application server

Flask app restarts using Gunicorn inside a virtual environment

Browser reflects the latest changes

This setup follows real production practices.

2. Architecture Diagram (Logical Flow)
Developer → GitHub → Jenkins Server → Application Server → Browser
Components

GitHub – Source code repository

Jenkins Server – CI/CD automation

Application Server – Runs Flask + Gunicorn

Gunicorn – WSGI server

Python venv – Dependency isolation

3. Prerequisites
Jenkins Server

Ubuntu/Debian VM

Jenkins installed

Git installed

SSH access to Application Server

Application Server

Ubuntu/Debian VM

Python 3.13+

Git installed

Network access from Jenkins

4. Flask Application Structure
flask-app/
├── app.py
├── requirements.txt
├── venv/
├── logs/
└── .gitignore
app.py (Sample)
from flask import Flask


app = Flask(__name__)


@app.route('/')
def home():
    return "Flask CI/CD deployment working!"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
requirements.txt
flask
gunicorn
.gitignore
venv/
logs/
__pycache__/
5. GitHub Repository Setup

Create a GitHub repository

Push Flask application code

git init
git add .
git commit -m "Initial Flask app"
git branch -M main
git remote add origin https://github.com/<username>/<repo>.git
git push -u origin main
6. Application Server Setup
6.1 Clone Repository
cd /opt
git clone https://github.com/<username>/<repo>.git flask-app
cd flask-app
6.2 Create Virtual Environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
6.3 Run Flask with Gunicorn
source venv/bin/activate
gunicorn app:app --bind 0.0.0.0:5000 --daemon
7. Jenkins Server Configuration
7.1 Required Packages
sudo apt update
sudo apt install -y git
7.2 Fix Jenkins Permissions
sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo chmod -R u+rwX /var/lib/jenkins
sudo chmod 1777 /tmp
sudo systemctl restart jenkins
8. Jenkins Job Configuration
8.1 Create Pipeline Job

New Item → Pipeline

Pipeline Definition: Pipeline script from SCM

SCM: Git

Repository URL: GitHub repo URL

Branch: main

9. Jenkinsfile (Complete)
pipeline {
    agent any


    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/<username>/<repo>.git'
            }
        }


        stage('Deploy to Application Server') {
            steps {
                sh '''
                ssh appuser@app-server << EOF
                  cd /opt/flask-app
                  git pull origin main
                  source venv/bin/activate
                  pkill gunicorn || true
                  gunicorn app:app --bind 0.0.0.0:5000 --daemon
                EOF
                '''
            }
        }
    }
}
10. GitHub Webhook Setup

Repository → Settings → Webhooks

Payload URL:

http://<jenkins-ip>:8080/github-webhook/

Content type: application/json

Enable GitHub hook trigger for GITScm polling in Jenkins

11. Deployment Workflow

Developer pushes code to GitHub

GitHub webhook triggers Jenkins

Jenkins pulls latest code

Jenkins SSHs into app server

Code updated using git pull

Gunicorn restarted using venv

Browser reflects new changes

12. Common Issues & Fixes
Code not updating

Gunicorn not restarted

Jenkins git error (spawn helper)

Fix /tmp permissions

Fix /var/lib/jenkins ownership

gunicorn command not found

Use Python virtual environment

13. Security Best Practices

Use SSH keys instead of passwords

Run Gunicorn as non-root user

Do not install Python packages globally

14. Future Improvements

systemd service for Gunicorn

Nginx reverse proxy

Rollback support

Prometheus & Grafana monitoring

15. Conclusion

This project demonstrates a production-style CI/CD pipeline using Flask, Jenkins, GitHub, and Gunicorn with virtual environments.

It covers real-world issues and fixes, making it suitable for learning, interviews, and portfolio project
