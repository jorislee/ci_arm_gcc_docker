# arm-none-eabi-gcc compilation environment docker

Based on python: 3.7.6 configure arm-none-eabi-gcc compilation environment docker.

## Dockerfile
  ``` shell
  #python:3.7.6
  FROM python:3.7.6

  ARG DEBIAN_FRONTEND=noninteractive

  # Install any needed packages specified in requirements.txt
  RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    git \
    bzip2 \
    cmake \
    wget && \
    apt-get clean

  # Download and configure the toolchain
  RUN cd /opt/ && wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj && cd -

  ENV PATH "/opt/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"
  ```

## License

MIT License.

## Acknowledgments

* Stackoverflow
