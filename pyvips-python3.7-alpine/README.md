# Make a pyvips / python 3.7 / libvips 8.8 / alpine stack

# Rebuild the image

```
docker pull alpine:latest
docker build -t pyvips-python3.7-alpine .
```

# Run the demo

```
docker run --rm -t -v $PWD:/data pyvips-python3.7-alpine \
		./wobble.py test.jpg x.jpg
```


```
docker run --rm -t -v $PWD:/data pyvips-python3.7-alpine \
		./soak.py test.jpg x.tif
```
