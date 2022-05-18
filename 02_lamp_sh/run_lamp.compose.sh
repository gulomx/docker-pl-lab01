#!/bin/bash

mkdir -p ./data/mssql2019 &&
    mkdir -p ./data/lamp &&
    mkdir -p ./data/mysql8
    sudo chown -R 10001:0 ./data/mssql2019 &&
    sudo chmod 777 -R ./data/lamp 
    
docker-compose up -d &&
echo "$(tput setaf 2)"Srodowsko powinno byc widoczne na portach: web 8080, mysql 23306, mssql 22433"$(tput sgr0)"

docker ps

