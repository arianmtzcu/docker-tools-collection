FROM openjdk:11.0.10-jre-buster

ENV KAFKA_VERSION 3.1.0
ENV SCALA_VERSION 2.13

RUN mkdir /tmp/kafka && \
    apt-get update && \
    apt-get install -y curl
         
RUN curl "https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" \
    -o /tmp/kafka/kafka.tgz && \
    mkdir /kafka && cd /kafka && \
    tar -xvzf /tmp/kafka/kafka.tgz --strip 1

ADD start-zookeeper.sh /usr/bin
RUN chmod +x  /usr/bin/start-zookeeper.sh

EXPOSE 2181

CMD ["/usr/bin/start-zookeeper.sh"]
