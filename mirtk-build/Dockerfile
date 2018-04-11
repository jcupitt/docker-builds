# container for centos7, suitable for the HPC cluster

FROM centos:latest

MAINTAINER John Cupitt <jcupitt@gmail.com>
LABEL Description="Medical Image Registration ToolKit (MIRTK)" 

RUN yum update -y

RUN yum install -y gcc wget

WORKDIR /data

# install FSL
COPY FSL/fslinstaller.py /data

RUN python2 /data/fslinstaller.py -d /data/FSL -q


