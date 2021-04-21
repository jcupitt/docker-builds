PDFIUM_VERSION=4290
PDFIUM_URL=https://github.com/bblanchon/pdfium-binaries/releases/download/chromium

cd /usr/local/src
wget -N ${PDFIUM_URL}/${PDFIUM_VERSION}/pdfium-linux.tgz
cd ${PREFIX}
tar xf /usr/local/src/pdfium-linux.tgz

cat > ${PREFIX}/lib/pkgconfig/pdfium.pc << EOF
prefix=${PREFIX}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: pdfium
Description: pdfium
Version: ${PDFIUM_VERSION}
Requires:
Libs: -L\${libdir} -lpdfium
Cflags: -I\${includedir}
EOF
