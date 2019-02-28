# Make a pyvips / libvips master / alpine stack

# Rebuild the image

  docker pull alpine:latest

	docker build -t pyvips-alpine:master .

# Run the demo

	docker run --rm -t -v $PWD:/data pyvips-alpine:master \
		./wobble.py test.jpg x.jpg

