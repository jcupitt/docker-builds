FROM ubuntu:20.10

RUN apt-get update \
	&& apt-get install -y 

RUN apt-get install -y \
	libvips \
	libvips-tools 

RUN echo -n "vips binary: "; which vips \
	&& echo -n "linked to libjpeg: "; ldd $(which vips) | grep jpeg \
	&& echo -n "supplied by package: "; dpkg -S libjpeg.so.8

