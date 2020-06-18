FROM rpradesh/ubuntu:20.04.0

ARG JAVA_AWS_VERSION=8.252.09.1
ARG SCALA_VERSION=2.12.8

ENV JAVA_HOME=/amazon-corretto-${JAVA_AWS_VERSION}-linux-x64 \
SCALA_HOME=/scala-${SCALA_VERSION}



WORKDIR /

RUN	wget --no-check-certificate -q  \
    https://corretto.aws/downloads/resources/${JAVA_AWS_VERSION}/amazon-corretto-${JAVA_AWS_VERSION}-linux-x64.tar.gz && \
	tar xfz amazon-corretto-${JAVA_AWS_VERSION}-linux-x64.tar.gz && \
	rm amazon-corretto-${JAVA_AWS_VERSION}-linux-x64.tar.gz \
	&& \
	wget --no-check-certificate -q \
	https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz -O /scala-${SCALA_VERSION}.tgz && \
	tar xfz /scala-${SCALA_VERSION}.tgz && \
	rm /scala-${SCALA_VERSION}.tgz 

# COPY settings.xml $MVN_HOME/conf

ENV PATH="$PATH:$JAVA_HOME/bin:$SCALA_HOME/bin"