# pyvips / ubuntu 21.04

# Rebuild the image

```
docker pull ubuntu:21.04
docker build -t pyvips-ubuntu21.04 .
```

# Run a shell in the container

Current directory mounted as `/data`.

```
docker run -it --rm -v $PWD:/data pyvips-ubuntu21.04
```

Verify pyvips mode:

```
$ docker run -it --rm -v $PWD:/data pyvips-ubuntu21.04
root@67e69204dec0:/# python3
Python 3.9.4 (default, Apr  4 2021, 19:38:44) 
[GCC 10.2.1 20210401] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import pyvips
>>> pyvips.API_mode
True
>>> 
```
