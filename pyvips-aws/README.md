# Make a pyvips / lib vips8.6.3 / amazonlinux stack

# Rebuild the image

	docker pull amazonlinux:2018.03.0.20180424

	docker build -t pyvips-amazonlinux .

# Run the demo

	docker run --rm -t -v $PWD:/data pyvips-amazonlinux \
		./wobble.py test.jpg x.jpg

