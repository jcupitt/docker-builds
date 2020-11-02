# Build MSM against FSL6 on Ubuntu 16.04 (xenial)

`fslinstaller.py` downloaded 7/10/19

Build

```
docker pull ubuntu:xenial
docker build -t jcupitt/msm .
```

Shell in image

```
docker run --rm -it -u $(id -u):$(id -g) -v $PWD:/data jcupitt/msm /bin/bash
```

Login to dockerhub and push the image. The password is a special access token
for 2fa.

```
$ docker login --username jcupitt
Password:
$ docker push jcupitt/msm
```
