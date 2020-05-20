FROM ubuntu:18.04

# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get install -yq \
    ccache libncurses5-dev libssl-dev \
    net-tools git bzip2 cmake \
    bc bison flex util-linux dosfstools e2fsprogs \
    wget make git gdb libusb-dev libusb-1.0 \
    libtool autotools-dev  automake pkg-config usbutils scons

RUN git clone git://git.code.sf.net/p/openocd/code openocd-code &&\
    cd openocd-code && \
    git checkout tags/v0.9.0 && \
    ./bootstrap && \
    ./configure --enable-maintainer-mode --disable-werror --enable-jlink --enable-stlink && \
    make && \
    make install

RUN apt-get install gdb-multiarch && rm -rf /var/lib/apt/lists/*

# Download and configure the toolchain
RUN cd /opt/ && wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj && cd -

ENV PATH "/opt/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"

CMD [ "/bin/bash" ]
