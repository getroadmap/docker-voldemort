FROM java:7

RUN apt-get update && apt-get install -y wget unzip

ENV VOLDEMORT_VERSION=release-1.10.17-cutoff
RUN wget https://github.com/voldemort/voldemort/archive/$VOLDEMORT_VERSION.zip
RUN unzip $VOLDEMORT_VERSION.zip && mv voldemort-* voldemort

WORKDIR /voldemort/

ENV VOLDEMORT_HOME /voldemort/config/single_node_cluster
ADD chronos-store.xml /voldemort/config/single_node_cluster/config/STORES/
ADD cluster.xml /voldemort/config/single_node_cluster/config/
RUN ./gradlew clean build -x test

EXPOSE 6666 6667 8081

CMD ./bin/voldemort-server.sh

