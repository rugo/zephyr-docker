FROM ubuntu:20.04

WORKDIR /root

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
	apt install --no-install-recommends -y git cmake ninja-build gperf \
    ccache dfu-util device-tree-compiler wget \
    python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
    make gcc gcc-multilib g++-multilib libsdl2-dev && apt-get upgrade -y && \
	rm -rf /var/lib/apt/lists/*

RUN wget https://apt.kitware.com/kitware-archive.sh && bash kitware-archive.sh && apt-get upgrade -y

RUN pip3 install west
RUN west init ~/example_proj && cd ~/example_proj && west update && west zephyr-export
RUN pip3 install -r ~/example_proj/zephyr/scripts/requirements.txt 

RUN cd ~ && wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.13.1/zephyr-sdk-0.13.1-linux-x86_64-setup.run &&  \
    chmod +x zephyr-sdk-0.13.1-linux-x86_64-setup.run && \
    ./zephyr-sdk-0.13.1-linux-x86_64-setup.run --quiet -- -d ~/zephyr-sdk-0.13.1
