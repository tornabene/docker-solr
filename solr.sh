#!/bin/sh -e

# Starts, stops, and restarts solr

SOLR_DIR="/opt/solr/example"
JAVA_OPTIONS="-Xmx1024m -DSTOP.PORT=8079 -DSTOP.KEY=stopkey  -Dsolr.clustering.enabled=true  -jar start.jar"
LOG_FILE="/var/log/solr.log"
JAVA="/usr/bin/java"

case $1 in
    start)
        echo "Starting Solr"
        cd $SOLR_DIR
        $JAVA $JAVA_OPTIONS 2> $LOG_FILE &
        ;;
    stop)
        echo "Stopping Solr"
        cd $SOLR_DIR
        $JAVA $JAVA_OPTIONS --stop
        ;;
    restart)
        $0 stop
        sleep 1
        $0 start
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}" >&2
        exit 1
        ;;
esac

