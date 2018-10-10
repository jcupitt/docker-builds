FROM ubuntu:bionic

RUN apt-get update && apt-get install -y 

RUN apt install -y libvips42 ruby

# install the gem ... we need build-essential to be able to build the native
# parts of the ffi gem that ruby-vips uses
RUN apt install -y build-essential ruby-dev

RUN gem install ruby-vips

