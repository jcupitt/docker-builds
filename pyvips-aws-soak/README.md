# Soak test pyvips on AWS

# Build image

```
docker pull amazonlinux:2018.03
docker build -t pyvips-amazonlinux:2018.03 .
```

# Run the stack

```
docker run --rm -it -v $PWD:/data pyvips-amazonlinux:2018.03 \
  python3 /data/soak.py Gugg_coloured.jpg x.tif
```

