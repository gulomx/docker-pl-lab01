#!/bin/bash

docker-compose down
mkdir -p ./data/mssql2019 &&
  mkdir -p ./data/lamp &&
  mkdir -p ./data/mysql8
sudo chown -R 10001:0 ./data/mssql2019 &&
  sudo chmod 777 -R ./data/lamp &&
  docker build --pull --rm -f "build/php/Dockerfile" -t php:pl-run "build/php" &&
  docker build --pull --rm -f "build/httpd/Dockerfile" -t httpd:pl-run "build/httpd" &&
  # docker image ls &&
  echo "version: '3.3'
services:
  mysqldb:
    image: mysql:8
    environment:
      MYSQL_DATABASE: 'lamp_db'
      MYSQL_USER: 'lamp_user'
      MYSQL_PASSWORD: '89423reufabvjkwsagiuolr'
      MYSQL_ROOT_PASSWORD: 'vfASDf433dajhgbfieruwep23edefgregvFGfj'
    volumes:
      - $(pwd)/data/mysql8:/var/lib/mysql
    ports:
      - '3306:3306'
    networks:
      - lamp

  mssqldb:
    image: mcr.microsoft.com/mssql/server:2019-latest
    environment:
      - SA_PASSWORD=Pass@word
      - ACCEPT_EULA=Y
    volumes:
      - $(pwd)/data/mssql2019:/var/opt/mssql
    ports:
      - \"22433:1433\"
    networks:
      - lamp



  httpd:
    image: httpd:pl-run
    volumes:
      - $(pwd)/data/lamp:/src/public
    depends_on:
      - php
      - mysqldb
      - mssqldb
    deploy:
      replicas: 3
      labels:
        - traefik.enable=true
        - traefik.docker.network=traefik-public
        - traefik.constraint-label=traefik-public
        - traefik.http.routers.lamp-http.rule=Host(\`lamp-stack.test.local\`)
        - traefik.http.routers.lamp-http.entrypoints=http
        - traefik.http.routers.lamp-http.middlewares=https-redirect
        - traefik.http.routers.lamp-https.rule=Host(\`lamp-stack.test.local\`)
        - traefik.http.routers.lamp-https.entrypoints=https
        - traefik.http.routers.lamp-https.tls=true
        - traefik.http.routers.lamp-https.tls.certresolver=le
        - traefik.http.services.lamp_httpd.loadbalancer.server.port=80
    ports:
      - '4488:80'
    networks:
      - lamp
      - traefik-public

  php:
    image: php:pl-run
    volumes:
      - $(pwd)/data/lamp/:/src/public
    depends_on:
      - mysqldb
      - mssqldb
    deploy:
      replicas: 3
    networks:
      - lamp

networks:
  lamp:
    driver: overlay
  traefik-public:
    external: true" >lamp-traefik.yml

docker network create --driver=overlay --attachable traefik-public

docker stack deploy -c lamp-traefik.yml lamp
echo "Zainicfowano usługi:"
docker service ls
echo "Uruchom traefik by dostac się do usług"
