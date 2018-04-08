#!/bin/sh

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

# ubuntu 17.10
docker pull ubuntu:artful

# Create a machine image with all the required build tools pre-installed
docker build -t pdfium-build container

# Run build scripts inside container, with data subdirectory mounted at 
# /data
docker run --rm -t -v $PWD/data:/data pdfium-build \
	sh -c "./build-pdfium.sh \
		&& ./package.sh"

# List result
ls -al $PWD/data/package/*.tar.gz
