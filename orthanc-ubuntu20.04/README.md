# orthanc on ubuntu 20.04

```
docker pull ubuntu:focal
docker build -t orthanc-ubuntu20.04 .
docker run -it --rm -v $PWD:/data -p 8042:8042 orthanc-ubuntu20.04 
```
