#!/usr/bin/env bash

PROJECTS=~/projects/haste



# build the docker image, push
cd $PROJECTS/haste-image-analysis-container
#docker build --no-cache=true -t "benblamey/haste-image-proc:latest" . ; docker push benblamey/haste-image-proc:latest
read -p "Press enter to continue"

cd $PROJECTS/HarmonicIOSetup

# Pull images on all worker machines
ansible -i hosts_HPC2N-haste-prod master:workers -a "sudo docker pull benblamey/haste-image-proc"
read -p "Press enter to continue"

# Restart HIO
ansible-playbook -i hosts_HPC2N-haste-prod playbooks/stopMasterWorker.yml
ansible-playbook -i hosts_HPC2N-haste-prod playbooks/startMasterWorker.yml
ansible -i hosts_HPC2N-haste-prod workers:master -a "sh -c 'netstat --numeric --listening --tcp | grep --line-buffered --extended \"(8080|8888)\"'"
read -p "Press enter to continue"


# Run this on from inside the cloud:
# ssh hio-worker-prod-0-2

# for i in {1..10}; do curl -X POST "http://hio-worker-prod-0-${i}:8888/docker?token=None&command=create" --data '{"c_name" : "benblamey/haste-image-proc:latest", "num" : 1}'; done


# Inspect logs of most recent worker:
# sudo docker ps --all -n 1 -q | sudo xargs docker logs
