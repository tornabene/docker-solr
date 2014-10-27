docker-solr
===========


### To build:
	Spostarsi nella directory e lanciare il comando
    sudo docker build -t tornabene/docker-solr .
    

### To run:

    sudo docker pull tornabene//docker-solr
    sudo docker run -d --name solr.ntipa.it -p 8983:8983  tornabene//docker-solr
    
    
    