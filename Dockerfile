#FROM centos
FROM centos:latest
MAINTAINER yosugi

# change timezone to JST
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# install busybox
RUN yum -y update
RUN yum groupinstall "Development Tools" -y

# build busybox
WORKDIR /root
RUN git clone git://busybox.net/busybox.git
WORKDIR /root/busybox
RUN make defconfig
RUN make

RUN mkdir -p /var/spool/cron/crontabs/

# write your crontab setting to root file
ADD root /var/spool/cron/crontabs/root

CMD ["./busybox", "crond", "-f"]
