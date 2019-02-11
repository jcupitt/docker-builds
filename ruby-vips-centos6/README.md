# Make ruby-vips for centos6

You have to make your own libgsf, since the centos6 one is too old.

# Rebuild the image

    docker pull centos:6

    docker build -t ruby-vips-centos6 .

# Run the demo

    docker run --rm -t \
      -v $PWD:/data \
      ruby-vips-centos6 \
      ./wobble.rb test.jpg x.jpg

