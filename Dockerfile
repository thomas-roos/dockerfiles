FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm zstd locales cpio lz4 sudo
RUN useradd -U -m yoctouser
RUN /usr/sbin/locale-gen en_US.UTF-8
RUN mkdir -p /home/yoctouser/yocto && \
cd /home/yoctouser/yocto && \
git clone git://git.yoctoproject.org/poky -b  master && \
git clone https://github.com/aws4embeddedlinux/meta-aws -b master-next && \
cd meta-aws && git checkout 72d45f9f4157f50292720f26f71b5a65b219f782 && cd - && \
git clone https://github.com/openembedded/meta-openembedded.git -b master && \
source poky/oe-init-build-env && \
bitbake-layers add-layer ../meta-openembedded/meta-oe && \
bitbake-layers add-layer ../meta-openembedded/meta-python && \
bitbake-layers add-layer ../meta-openembedded/meta-networking && \
bitbake-layers add-layer ../meta-aws
RUN chown -R yoctouser: /home/yoctouser/yocto
RUN echo 'yoctouser  ALL=(ALL) /bin/su' >>  /etc/sudoers
USER yoctouser
WORKDIR /home/yoctouser
CMD /bin/bash
