FROM powerkvm/dumb-init-ppc64le
MAINTAINER Lu Bin <lblulb@cn.ibm.com>

RUN yum -y install cyrus-sasl-md5 subversion

RUN rpm -ivh http://pokgsa.ibm.com/projects/i/ibm-mesos/power/mesos-1.0.0-2016080804.ael7b.ppc64le.rpm

#RUN yum -y install docker-io  
RUN rpm -ivh http://ftp.unicamp.br/pub/ppc64el/rhel/7_1/docker-ppc64el/docker-io-1.9.1-20151210git18bfacb.ael7b.ppc64le.rpm

CMD ["/opt/ibm/mesos/sbin/mesos-slave"]

ENV MESOS_WORK_DIR /tmp/mesos
ENV MESOS_CONTAINERIZERS docker,mesos

# https://mesosphere.github.io/marathon/docs/native-docker.html
ENV MESOS_EXECUTOR_REGISTRATION_TIMEOUT 5mins

# https://issues.apache.org/jira/browse/MESOS-4675
ENV MESOS_SYSTEMD_ENABLE_SUPPORT false

VOLUME /tmp/mesos

COPY entrypoint.sh /

ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint.sh"]
