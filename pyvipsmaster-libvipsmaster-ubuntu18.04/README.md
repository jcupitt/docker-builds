# Make a pyvips master / libvips master / ubuntu stack

# Rebuild the image

	docker pull ubuntu:bionic

	docker build -t pyvips-ubuntu:master .

	docker run -it --rm -v $PWD:/data pyvips-ubuntu:master

# Run the demo

	docker run --rm -t -v $PWD:/data pyvips-ubuntu:master \
		./wobble.py test.jpg x.jpg

