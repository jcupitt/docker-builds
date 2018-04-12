#!/bin/sh

if [ $# -lt 1 ]; then
  echo "Usage: $0 BRANCH"
  echo "Build BRANCH of the structural pipeline using Docker"
  echo "BRANCH is the name of a versioned subdirectory, e.g. v1.1"
  exit 1
fi

VERSION="$1"

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

# update the base image
docker pull ubuntu:xenial

# build the container, including prerequisites
docker build -t build-structural-pipeline container

# run the build for the selected version
docker run --rm -t -v $PWD/$VERSION:/data -e "VERSION=$VERSION" build-structural-pipeline sh -c "./build.sh"
