# pyvips on Debian stretch

# Rebuild the image

	docker pull debian:stretch

	docker build -t pyvips-stretch .

	docker run -it --rm -v $PWD:/data pyvips-stretch


