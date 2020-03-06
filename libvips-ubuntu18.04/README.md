# libvips 8.8 / ubuntu 16.04

libvips docs fail to build correctly 19.04 due perhaps to some pandoc problems.

Build the docs on 16.04 instead.

# Rebuild the image

```
docker pull ubuntu:xenial
docker build -t libvips-ubuntu16.04 .
docker run -it --rm -v $PWD:/data libvips-ubuntu16.04 
```

And copy the formatted docs out.

# Debug

output

    DOC   Preparing build
    DOC   Scanning header files
    DOC   Introspecting gobjects
  WARNING:root:Running scanner failed: -11, command: /bin/bash ../libtool --mode=execute ./libvips-scan

After make fails in container:

  cd doc
  ../libtool --mode=execute ./libvips-scan

segv

  cd doc
  ../libtool --debug --mode=execute ./libvips-scan

output

  ++ exec ./libvips-scan
  Segmentation fault (core dumped)

try with -g so we can see segv in gdb

docker needs to allow this

  docker run --rm -it --security-opt seccomp=unconfined 56d33457c6dc
  cd /usr/local/src
  wget https://github.com/libvips/libvips/releases/download/v8.8.0/vips-8.8.0.tar.gz
  tar xf vips-8.8.0.tar.gz
  cd vips-8.8.0
  CFLAGS="-g" ./configure --enable-gtk-doc
  make V=0
  cd doc
  apt install gdb
  LD_LIBRARY_PATH=../libvips/.libs gdb .libs/libvips-scan
  run

failing in 

  g_mutex_lock(vips__global_lock)
  vips_object_class_init()
  ...
  g_type_class_ref 
  get_object_types() libvips-scan.c:66

perhaps we need vips_init()? that's where `vips_global_lock` is made

why do we need a scanner anyway? can't we use the GIR? check the docs

how does this work not in docker? do we build an run a scanner in doc/ ?
