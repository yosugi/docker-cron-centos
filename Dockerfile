#FROM centos
FROM centos:latest
MAINTAINER yosugi

# install crontabs
RUN yum -y update
RUN yum -y install crontabs

# change timezone to JST
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# comment out PAM
RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/crond

ADD cron-test /etc/crontab
RUN chmod 0644 /etc/crontab
RUN touch /tmp/test.txt

CMD crond && tail -f /dev/null