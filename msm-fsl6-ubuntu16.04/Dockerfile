FROM ubuntu:xenial
LABEL Description="MSM on FSL6 on ubuntu 16.04" 

# install prerequsites
# - build tools ... FSL6 on ubuntu is gcc 4.8
#	$ objdump -s --section .comment  /usr/local/fsl/bin/fabber
#	fabber:     file format elf64-x86-64
#
#	Contents of section .comment:
#	 0000 4743433a 2028474e 55292034 2e382e35  GCC: (GNU) 4.8.5
#	 0010 20323031 35303632 33202852 65642048   20150623 (Red H
#	 0020 61742034 2e382e35 2d333629 00        at 4.8.5-36).   
# - FSL 6.0.0 needs "dc" 
# - FSL latest

RUN apt-get update
RUN apt-get install -y \
    gcc-4.8 g++-4.8 \
    wget git cmake unzip bc python python-contextlib2 \
    libtbb-dev libboost-dev zlib1g-dev libxt-dev libexpat1-dev \
    libgstreamer1.0-dev libqt4-dev dc

# install FSL to this prefix ... don't set FSLDIR as an ENV, it'll appear in
# the image we make and break stuff downstream
ENV fsl_prefix=/usr/local/fsl

# -E is not suported on ubuntu (rhel only), so we make a quick n dirty
# /etc/fsl/fsl.sh 
RUN mkdir -p /usr/local/src/fsl 
COPY fslinstaller.py /usr/local/src/fsl
RUN cd /usr/local/src/fsl \ 
    && python fslinstaller.py -V 6.0.2 -q -d $fsl_prefix \
    && mkdir -p /etc/fsl \
    && echo "FSLDIR=$fsl_prefix; . \${FSLDIR}/etc/fslconf/fsl.sh; PATH=\${FSLDIR}/bin:\${PATH}; export FSLDIR PATH" > /etc/fsl/fsl.sh 

# set FSL up for build:
# 	- ${FSLDIR}/etc/fslconf/fsl.sh needs to be patched to enable 
# 	  FSLCONFDIR, FSLMACHTYPE, and the associated export
COPY fsl.sh.patch /usr/local/src/fsl
RUN cd $fsl_prefix/etc/fslconf \
    && patch < /usr/local/src/fsl/fsl.sh.patch 

# switch the default compiler to 4.8 to match the fsl binary
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50 \
    && update-alternatives --set gcc /usr/bin/gcc-4.8 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50 \
    && update-alternatives --set g++ /usr/bin/g++-4.8

# now FSLMACHTYPE will be reported as gnu_64-gcc4.8 ... this is not a
# supported configuration (see the set of configs in /usr/local/fsl/config)
# so we take a copy of the closest one (linux_64-gcc4.8)
RUN cp -r $fsl_prefix/config/linux_64-gcc4.8 $fsl_prefix/config/gnu_64-gcc4.8

# FSL6 openblas needs libgfortran.so.3, but this is not linked as
# libgfortran.so ... fix this
RUN ln -s $fsl_prefix/lib/libgfortran.so.3 $fsl_prefix/lib/libgfortran.so

# download and set up MSM
# the struct-pipeline-build branch has a fix to the final MSM makefile
RUN cd && cd \
    && cd /usr/local/src \
    && . /etc/fsl/fsl.sh \
    && export FSLDEVDIR=$FSLDIR \
    && git clone https://github.com/jcupitt/MSM_HOCR.git \
    && cd MSM_HOCR \
    && git checkout struct-pipeline-build \
    && cp -r extras/ELC1.04/ELC $FSLDEVDIR/extras/include/ELC \
    && cp -r $FSLDIR/src/FastPDlib $FSLDEVDIR/extras/src 

# build MSM, and replace the FSL msm with our own
RUN cd /usr/local/src \
    && . /etc/fsl/fsl.sh \
    && export FSLDEVDIR=$FSLDIR \
    && cd MSM_HOCR \
    && cd src/newmesh \
    && make  \
    && make install \
    && cd ../DiscreteOpt \
    && make  \
    && make install \
    && cd $FSLDEVDIR/extras/src/FastPDlib/ \
    && make \
    && make install \
    && cd /usr/local/src/MSM_HOCR/src/MSMRegLib/ \
    && make \
    && make install \
    && cd ../MSM \
    && make \
    && make install \
    && cp msm $FSLDIR/bin \
    && cp msmapplywarp $FSLDIR/bin \
    && cp msmresample $FSLDIR/bin

WORKDIR /data

