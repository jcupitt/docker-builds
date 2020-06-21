# Build MIRTK to a prefix

# FSL

See `docker-builds/msm-fsl6-ubuntu16.04` for FSL plus latest MSM.

# Native build

These scripts download, configure, build and install eigen, VTK and MIRTK 
to a private prefix.

Try:

```
$ ./build-all.sh
```

Edit `build-all.sh` to change the install location. Edit `build-vtk.sh` to 
change the VTK version -- same for eigen and MIRTK.

# Docker build


```
docker build -t john/mirtk:centos .
```

