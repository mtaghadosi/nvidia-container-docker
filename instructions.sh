#!/bin/bash

wget https://nvidia.github.io/nvidia-docker/gpgkey --no-check-certificate
sudo apt-key add gpgkey
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit-base # or nvidia-container-toolkit
nvidia-ctk --version # check to see everything is working 
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml  # Generate a CDI specification
grep "  name:" /etc/cdi/nvidia.yaml #check the device name 


# UPDATE THE DOCKER DEAMON FILE OR INSTALL THE BELOW PACKAGE TO DO IT AUTOMATICALLY:
apt-get install -y nvidia-docker2

# Check to see the file is properly configured, it should be something like below:
#{
#    "runtimes": {
#        "nvidia": {
#            "path": "nvidia-container-runtime",
#            "runtimeArgs": []
#        }
#    },
#    "default-runtime": "nvidia"
#}
sudo systemctl restart docker
# Use --runtime=nvidia flag when running the container. 
# inside the container do nvidia-smi to see you are able to access the nvidia GPU or not

# created by Mohammad Taghadosi
