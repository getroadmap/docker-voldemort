FROM java:7

RUN apt-get update && apt-get install -y wget unzip

ENV VOLDEMORT_VERSION=release-1.10.17-cutoff
RUN wget https://github.com/voldemort/voldemort/archive/$VOLDEMORT_VERSION.zip
RUN unzip $VOLDEMORT_VERSION.zip && mv voldemort-* voldemort

WORKDIR /voldemort/

#ENV VOLDEMORT_HOME /voldemort/config/readonly_two_nodes_cluster
ENV VOLDEMORT_HOME /etc/voldemort/config/
RUN ./gradlew clean build -x test

ADD server.properties cluster.xml stores.xml /etc/voldemort/config/
ADD cluster.xml stores.xml /etc/voldemort/secondary/config/
ADD server.properties2 /etc/voldemort/secondary/config/server.properties

EXPOSE 6666 6667 8081

ENTRYPOINT ["./bin/voldemort-server.sh"]

