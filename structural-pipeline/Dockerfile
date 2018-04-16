FROM ubuntu:xenial
MAINTAINER John Cupitt <jcupitt@gmail.com>

# the one from the paper
ARG VERSION=dhcp-v1.1

# install prerequsites
# - FSL
# - build tools

RUN apt-get update 
RUN apt-get install -y apt-utils wget 
RUN wget -O- http://neuro.debian.net/lists/artful.de-m.full | tee /etc/apt/sources.list.d/neurodebian.sources.list 
RUN apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 
RUN apt-get update 
RUN apt-get install -y \
    fsl-complete \
    g++-5 git cmake unzip bc python python-contextlib2 \
    libtbb-dev libboost-dev zlib1g-dev libxt-dev libexpat1-dev \
    libgstreamer1.0-dev libqt4-dev

RUN cd /usr/src \
    && git clone https://github.com/BioMedIA/dhcp-structural-pipeline.git \
    && cd dhcp-structural-pipeline \
    && git checkout ${VERSION}

RUN ls /usr/src/dhcp-structural-pipeline \
    && NUM_CPUS=${THREADS:-`cat /proc/cpuinfo | grep processor | wc -l`} \
    && echo "Maximum number of build threads = $NUM_CPUS" \
    && cd /usr/src/dhcp-structural-pipeline \
    && ./setup.sh -j $NUM_CPUS

WORKDIR /data
ENTRYPOINT ["/usr/src/dhcp-structural-pipeline/dhcp-pipeline.sh"]
CMD ["-help"]

