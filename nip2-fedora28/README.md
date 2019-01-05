# Make a recent nip2 for fedora 28

# Rebuild the image

    docker pull fedora:28
    docker build -t nip2-fedora28 .

# Run the program

    xhost +
    docker run -it --rm \
      --env="DISPLAY" \
      --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
      --security-opt seccomp=unconfined \
      nip2-fedora28 /bin/bash

Then in the container:

    gdb nip2
