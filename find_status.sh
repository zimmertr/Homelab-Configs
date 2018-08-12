#!/bin/sh
echo '----------Summary-'
docker info | grep Containers
docker info | grep Running
docker info | grep Paused
docker info | grep Stopped
docker info | grep Images

echo;echo '----------Containers-'

count=1
for container in `docker ps -q`; do
    echo -n '$count) Name: '; docker inspect --format='{{.Config.Hostname}}' $container
    echo -n '   Status: '; docker inspect --format='{{.State.Status}}' $container
    echo '   Health: '; docker stats --no-stream --format 'table -   {{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}' $container

    echo
    echo -n '   Error: '; docker inspect --format='{{.State.Error}}' $container
    echo -n '   Exit Code: '; docker inspect --format='{{.State.ExitCode}}' $container
    echo -n '   Started: '; docker inspect --format='{{.State.StartedAt}}' $container
    echo
    count=$((count + 1))
done
