#!/bin/sh

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

docker pull heroku/heroku:18

# Create a machine image with all the required build tools pre-installed
docker build -t pdfium-heroku-build container

# Run build scripts inside container, with data subdirectory mounted at 
# /data
docker run --rm -t -v $PWD/data:/data pdfium-heroku-build \
	sh -c "./build-pdfium.sh \
		&& ./package.sh"

# List result
ls -al $PWD/data/package/*.tar.gz
