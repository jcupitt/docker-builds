# Make a pyvips / python3 stack

# Rebuild the image

  docker pull python:3

	docker build -t pyvips-python3 .

# Run the stack

	docker run --rm -it pyvips-python3

