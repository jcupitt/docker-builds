# Install php-vips on php 8.3

# Rebuild the image

```
docker pull ubuntu:jammy
docker build -t php-vips-php8.3 .
```

# Run composer to fetch php-vips master

```
docker run -t --rm \
		-v $PWD:/data \
		php-vips-php8.3 \
		composer update
```

# Run the demo

```
docker run --rm -t --rm \
		-v $PWD:/data \
		php-vips-php8.3 \
		./overlay.php blank-tshirt.jpg GOSHEN.svg x.jpg
```

