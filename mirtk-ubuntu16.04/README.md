# Build MIRTK for ubuntu 16.04

These scripts download, configure, build and install eigen, ITK and MIRTK in
an ubuntu16.04 docker container. They don't build viewer, since that needs VTK
and is a pain on older machines. 


Try:

```
docker build -t john/mirtk:xenial .
```

Edit `build-all.sh` to change the install location. Edit `build-itk.sh`
etc. to change the versions.


