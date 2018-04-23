# Make a php-vips / nginx / ubuntu 16.04 stack

This doesn't work at the moment -- looks like glib 2.28.4 (the centos glib) is 
too old, perhaps?

# Rebuild the image

	docker pull centos:6

	docker build -t ruby-vips-centos6 .

# Run the demo

	docker run --rm -t \
		-v $PWD:/data \
		ruby-vips-centos6 \
		./wobble.rb test.jpg x.jpg

