# Build MSM against FSL6 on Ubuntu 16.04 (xenial)

Build

```
docker pull ubuntu:xenial
docker build -t msm .
```

Shell in image

```
docker run --rm -it -v $PWD:/data msm /bin/bash
```
