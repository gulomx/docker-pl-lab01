#!/bin/bash
curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
docker stack deploy -c portainer-agent-stack.yml portainer

echo "Dzialajace uslugi portainera"
docker service ls | grep portainer
echo "Polacz sie na port 9443"