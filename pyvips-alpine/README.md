# Make a pyvips / libvips 8.15 / alpine stack

# Rebuild the image

```shell
docker pull alpine:latest
docker build -t pyvips-alpine .
```

# Run the demo

	docker run --rm -t -v $PWD:/data pyvips-alpine \
		./wobble.py test.jpg x.jpg

