FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get upgrade -y

RUN apt-get install -y \
	orthanc

WORKDIR /usr/local/orthanc-config

