FROM fedora:33

# fedora33 comes with ruby 2.7.2 and libvips 8.9.2
RUN yum update -y 
RUN yum -y install \
  vips \
  ruby-devel

# general build stuff ... the ffi gem needs this since it's a native extension
# libffi-devel needed by ffi gem
# redhat-rpm-config needed for cc1 hardening
RUN yum groupinstall -y "Development Tools" \
  && yum install -y \
 	wget \
	tar \
	libffi-devel \
	redhat-rpm-config

# install the gem ... 2.0.17 at time of testing
RUN gem install ruby-vips

WORKDIR /data
