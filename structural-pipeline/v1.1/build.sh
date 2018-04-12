#!/bin/sh

if [ ! -d structural-pipeline ]; then 
  git clone https://github.com/DevelopingHCP/structural-pipeline.git
fi

cd structural-pipeline
git pull
if ! git checkout $VERSION; then
  exit 1
fi

./setup.sh -j 4
