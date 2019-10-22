# Build MSM against FSL6 on Ubuntu 16.04 (xenial)

`fslinstaller.py` downloaded 7/10/19

Build

```
docker pull ubuntu:xenial
docker build -t msm .
```

Shell in image

```
docker run --rm -it -v $PWD:/data msm /bin/bash
```
