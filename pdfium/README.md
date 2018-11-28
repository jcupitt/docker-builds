# Build PDFium

See

https://github.com/libvips/libvips/issues/689

# Docker build

Make sure you are in the docker group, then enter:

	./build.sh

Should (eventually) generate:

	-rw-r--r-- 1 john lxd 25934631 Mar 30 17:18 /home/john/GIT/build-pdfium/data/package/libpdfium-master-linux-x64.tar.gz

# Native build

You can just run the `data/build-pdfium.sh` script directly. Seems to work 
on 17.10 at least. 
