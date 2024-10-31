#!/bin/bash

sudo apt-get update -yy

sudo apt-get install -yy git curl

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

docker run -e MYSQL_DATABASE="${mysql_database}" \
           -e  MYSQL_ROOT_PASSWORD="${mysql_root_password}" \
           -p 3306:3306 -v ./data:/var/lib/mysql -d mysql