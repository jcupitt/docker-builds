# Make a recent nip2 for fedora 28

# Rebuild the image

	docker pull fedora:28

	docker build -t nip2-fedora28 .

  xhost +
  docker run -it --rm -e DISPLAY=:0 nip2-fedora28 /usr/local/bin/nip2
