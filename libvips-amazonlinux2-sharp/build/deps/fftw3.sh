export FFTW3_VERSION=3.3.9

FFTW3_URL=http://www.fftw.org

cd /usr/local/src
wget -N ${FFTW3_URL}/fftw-${FFTW3_VERSION}.tar.gz
tar xzf fftw-${FFTW3_VERSION}.tar.gz
cd fftw-${FFTW3_VERSION}
./configure --prefix=${PREFIX} \
  --enable-static --disable-shared
make install-strip