# ruby-vips / libvips 8.7.1 / ubuntu 18.04

# Rebuild the image

	docker pull ubuntu:bionic

	docker build -t ruby-vips-libvips-ubuntu18.04 .

	docker run -it --rm -v $PWD:/data ruby-vips-libvips-ubuntu18.04 


