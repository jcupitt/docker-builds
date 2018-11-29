# Build PDFium for heroku:18

See

https://github.com/libvips/libvips/issues/689

# Docker build

Make sure you are in the docker group, then enter:

	./build.sh

Should (eventually) generate:

	-rw-r--r-- 1 john lxd 25934631 Mar 30 17:18 /home/john/GIT/build-pdfium-heroku18/data/package/libpdfium-master-linux-x64.tar.gz

# Native build

You can also just run the `data/build-pdfium.sh` script directly to make a
binary for the host platform.
