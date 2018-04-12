#!/bin/sh

if [ $# -lt 1 ]; then
  echo "Usage: $0 BRANCH subject_ID session_ID scan_age -T2 T2_image [-T1 T1_image] [-t num_threads]"
  echo "Run BRANCH of the structural pipeline using Docker"
  echo "BRANCH is the name of a versioned subdirectory, e.g. v1.1"
  exit 1
fi

VERSION="$1"
shift

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

if [ ! -f $VERSION/structural-pipeline/dhcp-pipeline.sh ]; then
  echo "Please build the pipeline first"
  exit 1
fi

# run the pipeline for the selected version
docker run --rm -t -v $PWD/$VERSION:/data -e "VERSION=$VERSION" build-structural-pipeline sh -c "cd structural-pipeline; ./dhcp-pipeline.sh $*"
