#!/bin/bash
#set traefik on docker
docker network create --driver=overlay --attachable traefik-public
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID
export EMAIL=test@test.local

export DOMAIN=traefik.test.local
export USERNAME=admin
export PASSWORD=admin
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)

# initial configurarion from: dockerswarm.rocks/traefik.yml
# curl -L dockerswarm.rocks/traefik.yml -o traefik.yml
docker stack deploy -c traefik.yml traefik &&
    docker service ls -f name=traefik

echo "Dodaj wpis do pliki hosts lub DNS traefik.test.local bylo rozwiazywane na $(hostname -I) login: $USERNAME haslo: $PASSWORD"
