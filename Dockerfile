FROM centos:6.6
MAINTAINER Yeonghoon Park <me@yhpark.io>

RUN yum install -y compat-gcc-34
RUN yum install -y compat-gcc-34-c++
RUN yum install -y tar patch
RUN yum install -y ncurses-devel ncurses

RUN ln /usr/bin/gcc34 /usr/bin/gcc
RUN ln /usr/bin/g++34 /usr/bin/g++

#RUN yum install -y compat-glibc-headers 5/26/15 commented by thinkhy
#RUN cp -r /usr/lib/x86_64-redhat-linux5E/include/* /usr/local/include/

RUN yum install -y perl
RUN yum install -y gdb

ENV setup_dir /setup
ENV pintos_dir /pintos

#ENV setup_dir  ../group0
#ENV pintos_dir ../group0/pintos


WORKDIR $setup_dir

ADD pintos-misc $setup_dir/pintos/src/misc/
ADD pintos-utils $setup_dir/pintos-utils/

#ADD http://jaist.dl.sourceforge.net/project/bochs/bochs/2.2.6/bochs-2.2.6.tar.gz $setup_dir/bochs-2.2.6.tar.gz

COPY bochs-2.2.6.tar.gz  $setup_dir/bochs-2.2.6.tar.gz
RUN ls -l $setup_dir/bochs-2.2.6.tar.gz
ADD bochs-2.2.6.tar.gz $setup_dir/bochs-2.2.6.tar.gz

RUN SRCDIR=$setup_dir DSTDIR=/usr/ PINTOSDIR=$setup_dir/pintos $setup_dir/pintos/src/misc/bochs-2.2.6-build.sh

#ADD http://pkgs.repoforge.org/qemu/qemu-0.15.0-1.el6.rfx.x86_64.rpm $setup_dir/qemu-0.15.0-1.el6.rfx.x86_64.rpm
ADD qemu-0.15.0-1.el6.rfx.x86_64.rpm $setup_dir/qemu-0.15.0-1.el6.rfx.x86_64.rpm
RUN yum install -y libGL SDL libaio alsa-lib bluez-libs celt051 esound-libs gnutls libjpeg-turbo pixman libpng pulseaudio-libs spice-server qemu-img
RUN rpm -i $setup_dir/qemu-0.15.0-1.el6.rfx.x86_64.rpm

RUN yum install -y arm-gp2x-linux-glibc
RUN ln -s /bin/qemu-system-i386 /bin/qemu

WORKDIR $setup_dir/pintos-utils/
RUN make

WORKDIR $pintos_dir

VOLUME [$pintos_dir]

env PATH $setup_dir/pintos-utils/:$PATH
