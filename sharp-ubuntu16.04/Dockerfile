FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    curl

WORKDIR /usr/src

# install node8 via the official PPA ... the nodejs that comes with 
# ubuntu16.04 is 4.x and is no longer supported
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh \
    && bash ./nodesource_setup.sh \
    && apt-get install -y nodejs

# and now sharp should go on with just npm
RUN npm install sharp
