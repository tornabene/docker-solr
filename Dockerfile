# NTIPA-SOLR 0.0.1
FROM tornabene/docker-ntipa-base
MAINTAINER Tindaro Tornabene <tindaro.tornabene@gmail.com>

ENV SOLR solr-4.10.2


WORKDIR /etc/supervisor/conf.d
ADD solr.conf  /etc/supervisor/conf.d/solr.conf

WORKDIR /opt
RUN wget http://apache.fastbull.org/lucene/solr/4.10.2/$SOLR.tgz -O /opt/$SOLR.tgz
ADD solr.sh  /opt/solr.sh
RUN chmod +x /opt/solr.sh

RUN ls -lah /opt
RUN tar -C /opt --extract --file /opt/$SOLR.tgz
RUN ln -s /opt/$SOLR /opt/solr


WORKDIR /opt/solr/example/solr
RUN cp -r collection1/ ntipa/

WORKDIR /opt/solr/example/solr/ntipa
RUN  echo "name=ntipa" > core.properties
RUN  cat core.properties

ADD schema.xml /opt/solr/example/solr/ntipa/conf/schema.xml
RUN rm -f /opt/solr/example/solr/ntipa/data/*

EXPOSE 22
EXPOSE 8983

CMD ["/usr/bin/supervisord"]
