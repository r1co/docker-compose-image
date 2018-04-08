FROM ubuntu:latest 

LABEL maintainer "r1co@post-box.cc"

USER root

RUN apt-get update && apt-get install -y tar wget curl  && rm -rf /var/lib/apt/lists/*

# install docker cli
RUN mkdir -p /tmp/_install && cd /tmp/_install && wget https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz  && tar -xvzf docker-latest.tgz && cd docker && cp docker /usr/bin/docker && rm -rf  /tmp/_install
RUN chmod +x /usr/bin/docker


# install docker-compose 
RUN curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN useradd -ms /bin/bash jenkins


RUN groupadd -g 999 docker
RUN usermod -a -G docker jenkins

USER jenkins
WORKDIR /home/jenkins