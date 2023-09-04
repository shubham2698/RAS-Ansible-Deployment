#!/bin/bash
sudo apt-get update
sudo apt-get install -y python3-pip
sudo pip3 install -y python3-flask
sudo apt-get install -y gunicorn3
sudo apt-get install -y nginx
git clone https://github.com/shubham2698/pibm_ra_13250.git
cd pibm_ra_13250/
sudo pip install -r requirements.txt
sudo mv flask_api.py app.py
cd /etc/nginx/sites-enabled/
echo 'server {
                  listen 80;
                  server_name 35.154.125.108;
              
                  location / {
                      proxy_pass http://127.0.0.1:8000;
                  }
              }' | sudo tee /etc/nginx/sites-enabled/flask-server.conf
sudo service nginx restart
cd ~/pibm_ra_13250/
gunicorn3 app:app
