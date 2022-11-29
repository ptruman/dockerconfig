#!/bin/sh
# Get Docker Config Script
# V1.0
# Declare a temp variable as the current process count
TMP=$$
# Count the existing Docker networks
DockerNetCount=`docker network ls | awk '{print $2}' | wc -l`
DockerNetCount=`expr $DockerNetCount - 1`
# For each identified Docker network, extract the member (Container) config
docker network ls | awk '{print $2}' | tail -$DockerNetCount | while read line
do
        docker network inspect $line > Docker_Net_$line.config
done
# For each identified Docker container, output it's config
docker ps --format '{{.Names}}' | while read line
do
        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/red5d/docker-autocompose $line > Docker_Container_AutoCompose_$line.yml
        docker container inspect $line > Docker_Container_InspectOutput_$line.txt
done
