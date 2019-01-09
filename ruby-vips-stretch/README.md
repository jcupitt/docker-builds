# ruby-vips on Debian stretch

# Rebuild the image

	docker pull debian:stretch

	docker build -t ruby-vips-stretch .

	docker run -it --rm ruby-vips-stretch /bin/bash


