# NTIPA-SOLR 0.0.1
FROM tornabene/docker-ntipa-base
MAINTAINER Tindaro Tornabene <tindaro.tornabene@gmail.com>

ENV SOLR solr-4.10.2


WORKDIR /etc/supervisor/conf.d
ADD solr.conf  /etc/supervisor/conf.d/solr.conf

WORKDIR /opt
RUN wget http://apache.fastbull.org/lucene/solr/4.10.2/$SOLR.tgz -O /opt/$SOLR.tgz

RUN ls -lah /opt
RUN tar -C /opt --extract --file /opt/$SOLR.tgz
RUN ln -s /opt/$SOLR /opt/solr
RUN whereis java
EXPOSE 22
EXPOSE 8983

CMD ["/usr/bin/supervisord"]
