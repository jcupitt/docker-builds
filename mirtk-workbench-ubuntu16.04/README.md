# Build MIRTK for ubuntu 16.04

These scripts download, configure, build and install eigen, ITK, MIRTK and
workbench in an ubuntu16.04 docker container. 

They don't build MIRTK viewer, since that needs VTK and is a pain on older 
machines. 

# Build

```
docker build -t jcupitt/mirtk-workbench:xenial .
docker push jcupitt/mirtk-workbench:xenial
```

Edit `build-itk.sh` etc. to change versions.
