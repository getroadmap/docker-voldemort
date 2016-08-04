FROM java:7

RUN apt-get update && apt-get install -y wget unzip

ENV VOLDEMORT_VERSION=release-1.10.17-cutoff
RUN wget https://github.com/voldemort/voldemort/archive/$VOLDEMORT_VERSION.zip
RUN unzip $VOLDEMORT_VERSION.zip && mv voldemort-* voldemort

WORKDIR /voldemort/

COPY chronos_voldy_cfg /voldemort/config/chronos_voldy_cfg
ENV VOLDEMORT_HOME /voldemort/config/chronos_voldy_cfg
RUN ./gradlew clean build -x test

EXPOSE 6666 6667 8081

CMD ./bin/voldemort-server.sh

