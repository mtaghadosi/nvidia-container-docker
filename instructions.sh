#!/bin/bash
# usefull links: https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda/tags
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/user-guide.html
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
# Then run the below command to apply the configuration to docker runtime then restart the docker daemon
sudo nvidia-ctk runtime configure --runtime=docker --set-as-default
sudo systemctl restart docker
 
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
# Use --runtime=nvidia flag when running the container. Or --gpus for older versions of docker 
# inside the container do nvidia-smi to see you are able to access the nvidia GPU or not

# created by Mohammad Taghadosi
