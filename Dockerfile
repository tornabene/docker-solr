# NTIPA-CONSUMER-VERSION 0.0.1
FROM ubuntu:trusty
MAINTAINER Tindaro Tornabene <tindaro.tornabene@gmail.com>

RUN apt-get update

RUN apt-get -y -q  install  python-software-properties software-properties-common
RUN apt-get -y install openssh-server && mkdir /var/run/sshd
RUN apt-get -y install supervisor
RUN apt-get install -yqq inetutils-ping net-tools

# install oracle java from PPA
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java7-installer && apt-get clean

# Set oracle java as the default java
RUN update-java-alternatives -s java-7-oracle
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> ~/.bashrc

WORKDIR /opt

WORKDIR /etc/supervisor/conf.d
RUN mkdir -p   /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# configure the "ntipa" and "root" users
RUN echo 'root:ntipa' |chpasswd
RUN groupadd ntipa && useradd ntipa -s /bin/bash -m -g ntipa -G ntipa && adduser ntipa sudo
RUN echo 'ntipa:ntipa' |chpasswd	
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV SOLR solr-4.10.1

WORKDIR /opt
RUN wget http://apache.panu.it/lucene/solr/4.10.1/$SOLR.tgz -O /opt/solr-$SOLR.tgz
RUN tar -C /opt --extract --file /opt/$SOLR.tgz
RUN ln -s /opt/$SOLR /opt/solr

EXPOSE 22
EXPOSE 8983

CMD ["/usr/bin/supervisord"]
