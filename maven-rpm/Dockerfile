#Url : https://hub.docker.com/r/spotx/maven-rpm/dockerfile
FROM maven:3-jdk-8

# CentOS needs Overlayfs plugin so we don't have problems with yum in Docker.
RUN apt-get -q update &&\
    apt-get -q install -y --no-install-recommends rpm &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y
