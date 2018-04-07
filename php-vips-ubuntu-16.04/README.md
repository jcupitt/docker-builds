# Make a php-vips / nginx / ubuntu 16.04 stack

# Rebuild the image

	docker pull ubuntu:xenial

	docker build -t php-vips-ubuntu-16.04 .

# Run the image

	docker run --rm -t php-vips-ubuntu-16.04 \
		./overlay.php blank-shirt.png GOSHEN.svg x.jpg

Currently fails with:

	$ docker run --rm -t php-vips-ubuntu-16.04 ./overlay.php blank-shirt.png
	GOSHEN.svg x.jpg
	PHP Fatal error:  Uncaught Jcupitt\Vips\Exception: VipsOperation: class
	"composite2" not found
	 in /data/vendor/jcupitt/vips/src/Image.php:664
	Stack trace:
	#0 /data/vendor/jcupitt/vips/src/Image.php(685): Jcupitt\Vips\Image::errorVips()
	#1 /data/vendor/jcupitt/vips/src/Image.php(1052): Jcupitt\Vips\Image::errorIsArray(-1)
	#2 /data/vendor/jcupitt/vips/src/Image.php(1130): Jcupitt\Vips\Image::callBase('composite2', Object(Jcupitt\Vips\Image), Array)
	#3 /data/overlay.php(17): Jcupitt\Vips\Image->__call('composite2', Array)
	#4 {main}
	   thrown in /data/vendor/jcupitt/vips/src/Image.php on line 664

Because the libvips in Ubuntu 16.04 is too old and does not have the composite
operator. 
