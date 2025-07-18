# Install php-vips on php 8.4

# Rebuild the image

```
docker pull php:8.4-fpm
docker build -t php-vips-php8.4 .
```

# Run composer to fetch php-vips master

```
docker run -t --rm \
		-v $PWD:/data \
		php-vips-php8.4 \
		composer update
```

# Run the demo

```
docker run --rm -t --rm \
		-v $PWD:/data \
		php-vips-php8.4 \
		./overlay.php blank-tshirt.jpg GOSHEN.svg x.jpg
```

