# Install php-vips on ubuntu 18.04 

# Rebuild the image

```
docker pull ubuntu:bionic
docker build -t php-vips-ubuntu-18.04 .
```

# Run composer to fetch php-vips

```
docker run -t \
		-v $PWD:/data \
		php-vips-ubuntu-18.04 \
		composer install
```

# Run the demo

```
docker run --rm -t \
		-v $PWD:/data \
		php-vips-ubuntu-18.04 \
		./overlay.php blank-tshirt.jpg GOSHEN.svg x.jpg
```
