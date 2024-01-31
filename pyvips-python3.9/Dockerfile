FROM python:3.9-slim

RUN apt-get update \
  && apt-get install -y \
	build-essential \
	pkg-config 

RUN apt-get -y install --no-install-recommends libvips-dev

RUN pip install pyvips 

WORKDIR /data
