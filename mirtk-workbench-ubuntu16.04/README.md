# Build MIRTK for ubuntu 16.04

These scripts download, configure, build and install eigen, ITK, MIRTK and
workbench in an ubuntu16.04 docker container. 

They don't build MIRTK viewer, since that needs VTK and is a pain on older 
machines. 


Try:

```
docker build -t mirtk-workbench:xenial .
```

Edit `build-itk.sh` etc. to change versions.
