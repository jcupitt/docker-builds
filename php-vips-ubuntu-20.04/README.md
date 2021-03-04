# Make a php-vips / nginx / ubuntu 16.04 stack

# Rebuild the image

```
docker pull ubuntu:focal
docker build -t php-vips-ubuntu-20.04 .
```

# Run composer to fetch php-vips

```
docker run -t \
		-v $PWD:/data \
		php-vips-ubuntu-20.04 \
		composer install
```

# Run the demo

```
docker run --rm -t \
		-v $PWD:/data \
		php-vips-ubuntu-20.04 \
		./overlay.php blank-tshirt.jpg GOSHEN.svg x.jpg
```
