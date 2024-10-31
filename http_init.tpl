#!/bin/bash

sudo apt-get update -yy

sudo apt-get install -yy git curl

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

#docker run --name my_app_container \
#            -e DB_HOST="${db_host}" \
#            -e DB_USER="${db_user}" \
#            -e DB_PASSWORD="${db_password}" \
#            -e DB_NAME="${db_name}" \
#            -e REDIS_HOST="${redis_host}" \
#            -v ./data:/var/lib/mysql \
#            -p 5000:5000 -d mohammad1406/capstone-project-1:latest

git clone https://github.com/mohammad1406/capstone-project.git
cd capstone-project

docker compose up -d