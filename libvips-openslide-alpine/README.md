# libvips with openslide on alpine

# Rebuild the image

	docker pull alpine:latest

	docker build -t libvips-openslide-alpine .

# Run

  docker run -it libvips-openslide-alpine vips

# Debug 

  docker run \
    --security-opt seccomp=unconfined \
    --rm \
    -it libvips-openslide-alpine bash
  apk add gdb glib-dbg
  gdb vips

