FROM python:3

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y libvips-dev 

RUN pip install pyvips

WORKDIR /data
