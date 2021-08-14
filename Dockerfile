FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Hong_Kong

# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get install -yq \
    ccache libncurses5-dev libssl-dev \
    net-tools git bzip2 cmake minicom \
    bc bison flex util-linux dosfstools e2fsprogs \
    wget make git gdb libusb-dev libusb-1.0 \
    libtool autotools-dev python3 python-is-python3 automake pkg-config usbutils scons

RUN git clone git://git.code.sf.net/p/openocd/code openocd-code &&\
    cd openocd-code && \
    git checkout tags/v0.9.0 && \
    ./bootstrap && \
    ./configure --enable-maintainer-mode --disable-werror --enable-jlink --enable-stlink && \
    make && \
    make install

RUN apt-get install gdb-multiarch && rm -rf /var/lib/apt/lists/*

# Download and configure the toolchain
RUN cd /opt/ && wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.07/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2 | tar -xj && cd -


ENV PATH "/opt/gcc-arm-none-eabi-10.3-2021.07/bin:$PATH"

CMD [ "/bin/bash" ]
