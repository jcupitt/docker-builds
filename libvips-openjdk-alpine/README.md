# libvips on openjdk:8-jre-alpine

# Rebuild the image

```
docker pull openjdk:8-jre-alpine
docker build -t libvips-openjdk-alpine .
```

# Run

```
$ docker run --rm -it -v $HOME/pics:/data libvips-openjdk-alpine 
```

# Debug 

```
docker run \
  --security-opt seccomp=unconfined \
  --rm \
  -it libvips-openjdk-alpine bash
apk add gdb glib-dbg
gdb vips
```
