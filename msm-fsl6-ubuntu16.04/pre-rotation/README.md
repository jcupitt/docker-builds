# Surface Atlas construction demo

This demo shows the current problem with surface atlas construction. 

# Running in docker

There's a Dockerfile to set up MIRTK and Workbench on Ubuntu 16.04 here:

https://github.com/jcupitt/docker-builds/tree/master/mirtk-workbench-ubuntu16.04

Build the docker image:

```
docker pull ubuntu:xenial
docker build -t mirtk-workbench:xenial .
```

Then run this script with:

```
docker run --rm -it -u $(id -u):$(id -g) -v $PWD:/data jcupitt/mirtk-workbench:xenial /bin/bash
cd /data
./run.sh
```

It should complete successfully, and generate `left_sphere.rot.surf.gii`.

# What's wrong

`sub-CC00692XX17_ses-200301_left_sphere.surf.gii` has 111820 points and
223646 triangles.

`left_sphere.rot.surf.gii` has 111825 points, 223646 triangles.

Although the number of triangles has stayed the same, the number of points has
changed. 

This causes (much later in processing) MSM to fail in surface atlas
construction when it attempts to load the mesh from `left_sphere.rot.surf.gii`
and the data from `sub-CC00692XX17_ses-200301_left_sulc.shape.gii`.

# Narrow it down

Display info on surface file:

```
gifti_test -infile sub-CC00692XX17_ses-200301_left_sphere.surf.gii -show
```

Look for:
  - `gim->darray[0]`, `NIFTI_INTENT_POINTSET`, dims = 111820,
  - `gim->darray[1]`, `NIFTI_INTENT_TRIANGLE`, dims = 223636

# Stages in pre-rot

`mirtk register` etc. just generates a transform and converts to a txt, so
this should be safe.

## `wb_command -surface-apply-affine` 

This reads `$in_sphere` and generates `$intermediate_sphere`.

  - `intermediate_sphere->darray[0]`, dims = 111820,

## `wb_command -surface-modify-sphere`

This reads and writes `tmp_rot.surf.gii`.

  - `tmp_rot.surf.gii->darray[0]`, dims = 111820

## `wb_command -surface-apply-affine`

Reads 



