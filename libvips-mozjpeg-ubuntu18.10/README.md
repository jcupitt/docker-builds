# libvips 8.7.2 / mozjpeg / ubuntu 18.10

# Rebuild the image

	docker pull ubuntu:cosmic

	docker build -t libvips-mozjpeg-ubuntu18.10 .

	docker run -it --rm -v $PWD:/data libvips-mozjpeg-ubuntu18.10


