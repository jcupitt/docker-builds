FROM ubuntu:bionic

RUN apt-get update \
	&& apt-get install -y 

# need the -dev version so that cffi can work in API mode .. it needs the .pc
# file to work out how to make a binary that's link-compatible with libvips.so
RUN apt-get install -y \
	libvips-dev \
	python3-pip

RUN pip3 install pyvips


