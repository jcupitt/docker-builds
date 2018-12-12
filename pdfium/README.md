# Build PDFium

See:

https://github.com/libvips/libvips/issues/689

https://github.com/lukas-w/pdfium-build

https://blog.openinworld.com/2017/11/pharo-pdf-part-1/

# Docker build

Make sure you are in the docker group, then enter:

	./build.sh

Should (eventually) generate:

	-rw-r--r-- 1 john lxd 25934631 Mar 30 17:18 /home/john/GIT/build-pdfium/data/package/libpdfium-master-linux-x64.tar.gz

# Native build

For a native build:

  cd data
  ./build-pdfium.sh
  ./package.sh

To make a tar file in `data/package`. Seems to work on 18.10.

