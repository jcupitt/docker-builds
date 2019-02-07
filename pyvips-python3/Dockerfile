FROM python:3

ENV PYTHONUNBUFFERED 1

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y libvips

RUN pip install pyvips
