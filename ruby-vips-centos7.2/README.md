# Make ruby-vips for centos 7.2

CentOS 7.2 comes with ruby 2.0, which just about works. You'd probably want
to replace it with a more recent ruby though.

# Rebuild the image

	docker pull centos:centos7.2.1511

	docker build -t ruby-vips-centos7.2 .

	docker run -it --rm -v $PWD:/data ruby-vips-centos7.2 



