FROM openjdk:11.0.10-jre-buster

ENV KAFKA_VERSION 3.1.0
ENV SCALA_VERSION 2.13

RUN apt-get update && \
    apt-get install -y curl 

RUN  mkdir /tmp/kafka && \
    curl "https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" \
    -o /tmp/kafka/kafka.tgz && \
    mkdir /kafka && cd /kafka && \
    tar -xvzf /tmp/kafka/kafka.tgz --strip 1

ADD start-kafka.sh  /usr/bin
RUN chmod +x  /usr/bin/start-kafka.sh

EXPOSE 9092

CMD ["/usr/bin/start-kafka.sh"]
   