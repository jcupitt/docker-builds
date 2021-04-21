#!/bin/sh

set -e

if ! type docker >/dev/null; then
  echo "Please install docker"
  exit 1
fi

echo "Building ..."
docker build -t dev-lambda amazonlinux
docker run --rm -v $PWD:/packaging dev-lambda sh -c "/packaging/build/vips.sh"