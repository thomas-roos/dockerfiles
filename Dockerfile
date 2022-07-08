FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm zstd locales cpio lz4 sudo
RUN useradd -U -m yoctouser
#necessary for cherry-pick
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN /usr/sbin/locale-gen en_US.UTF-8
RUN mkdir -p /home/yoctouser/yocto && \
cd /home/yoctouser/yocto && \
git clone git://git.yoctoproject.org/poky -b  master && \
git clone https://github.com/aws4embeddedlinux/meta-aws -b master && \
git clone https://github.com/openembedded/meta-openembedded.git -b master && \
cd meta-aws && \
git remote add tro https://github.com/thomas-roos/meta-aws.git && \
git fetch tro && \
git cherry-pick 46fdb3629d82f8037b1e34c03a25c86c0ca6139a && \
cd - && \
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

