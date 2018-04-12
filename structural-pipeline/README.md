# Build and run the dHCP pipeline in docker

This repro builds and runs the dHCP pipeline inside a docker container. See 
https://github.com/DevelopingHCP/structural-pipeline

Once you have docker installed, you can build and execute the entire
thing on any platform with a single command.

## Install docker

See https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/

Use `docker-ce`. Make sure there's no old docker on your system:

	sudo apt-get remove docker docker-engine docker.io

We need apt over https:

	sudo apt-get install apt-transport-https ca-certificates \
	   curl software-properties-common

Add docker's GPG key:

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
	   sudo apt-key add -

Add the repository:

	sudo add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	   $(lsb_release -cs) \
	   stable"

Install `docker-ce`:

	sudo apt-get update
	sudo apt-get install docker-ce

Test:

	sudo docker run hello-world

## Build the pipeline

Ask to build branch v1.1 of the pipeline:

	sudo ./build.sh v1.1

## Run the pipeline

Run the `dhcp-pipeline.sh` script:

	sudo ./docker-dhcp-pipeline.sh v1.1 subject1 session1 44 \
	  -T2 subject1-T2.nii.gz -T1 subject1-T1.nii.gz -t 8

## How it works

The `Dockerfile` in `container/` sets up a base image called
`build-structural-pipeline` containing the build prerequisites: Ubuntu
16.04 (xenial), FSL, and all the build tools. This image is cached and reused
between runs, so you only have to build it once.

`build.sh` then goes into the version subdirectory and in there, using the
container, runs the second `build.sh` script. This fetches the latest version
of the dHCP pipeline, checks out the version branch, and runs the dHCP
`setup.sh`.
