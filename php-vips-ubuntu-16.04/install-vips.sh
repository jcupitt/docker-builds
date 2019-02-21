#!/bin/bash 

version_major=$1
version_minor=$2
version_micro=$3
shift; shift; shift; 

url=https://github.com/libvips/libvips/releases/download
version=$version_major.$version_minor.$version_micro

set -e

# do we already have the correct vips built? early exit if yes
# we could check the configure params as well I guess
if [ -f /usr/bin/vips ]; then
	installed_version=$(vips --version)
	escaped_version="$version_major\.$version_minor\.$version_micro"
	echo "Need vips-$version"
	echo "Found $installed_version"
	if [[ "$installed_version" =~ ^vips-$escaped_version ]]; then
		echo "Using installed version"
		exit 0
	fi
fi

wget $url/v$version/vips-$version.tar.gz
tar xf vips-$version.tar.gz
cd vips-$version
CXXFLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 ./configure --prefix=/usr $*
make && make install
