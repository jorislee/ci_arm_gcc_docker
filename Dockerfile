#python:3.7.7
FROM python:3.7.7

# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get install -yq \
    git \
    bzip2 \
    cmake \
    wget && \
    apt-get clean

# Download and configure the toolchain
RUN cd /opt/ && wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj && cd -

ENV PATH "/opt/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"

CMD [ "/bin/bash" ]
