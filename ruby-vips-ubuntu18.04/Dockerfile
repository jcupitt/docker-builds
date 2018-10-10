FROM ubuntu:bionic

RUN apt-get update && apt-get install -y 

RUN apt install -y libvips42 ruby

# install the gem ... we need build-essential to be able to build the native
# parts of the ffi gem that ruby-vips uses
RUN apt install -y build-essential ruby-dev

RUN gem install ruby-vips

# sadly this isn't enough, ruby-vips tries to open 'glib-2.0' as a library,
# ruby-ffi turns this into 'libglib-2.0.so', but those .so links are made by
# glib-2.0-dev, which we have not installed

# root@5185a05b55dd:/usr/lib/x86_64-linux-gnu# ls -l libglib*
# lrwxrwxrwx 1 root root      23 Sep 17 12:52 libglib-2.0.so.0 -> libglib-2.0.so.0.5600.2
# -rw-r--r-- 1 root root 1133872 Sep 17 12:52 libglib-2.0.so.0.5600.2

