FROM matt/ubuntu-base:16.04

MAINTAINER Matt Leinhos <matthew.leinhos@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

#RUN sed -e 's:deb h:deb [arch=amd64] h:' -e 's:deb-src h:deb-src [arch=amd64] h:' -i /etc/apt/sources.list
#RUN find /etc/apt/sources.list.d/ -type f -exec sed -e 's:deb h:deb [arch=amd64] h:' -e 's:deb-src h:deb-src [arch=amd64] h:' -i {} \;

# Builder depends
RUN apt-get --quiet --yes update
RUN apt-get install --quiet --yes apt-utils       \
    	    	    	          kernel-package  \
				  libncurses5-dev \
				  fakeroot        \
				  wget            \
				  bzip2           \
				  build-essential \
				  bison           \
				  flex            \
				  libelf-dev
