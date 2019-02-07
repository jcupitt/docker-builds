# Make a pyvips / python3 stack

python3 is a Debian stretch image with py3 preinstalled.

# Rebuild the image

  docker pull python:3

	docker build -t pyvips-python3 .

# Run the stack

	docker run --rm -it pyvips-python3

