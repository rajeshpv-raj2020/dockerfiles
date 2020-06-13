FROM rpradesh/ubuntu:20.04.0

ARG JAVA_AWS_VERSION=8.252.09.1

ENV GROOVY_HOME=/groovy-3.0.4 \
MVN_HOME=/apache-maven-3.6.3 \
JAVA_HOME=/amazon-corretto-${JAVA_AWS_VERSION}-linux-x64 \
PROJECTS_HOME=/projects

WORKDIR /

RUN mkdir -p $PROJECTS_HOME && mkdir -p /M2-REPO && mkdir -p $MVN_HOME/conf \
	&& \
	wget --no-check-certificate -q  \
    https://corretto.aws/downloads/resources/${JAVA_AWS_VERSION}/amazon-corretto-${JAVA_AWS_VERSION}-linux-x64.tar.gz && \
	tar xfz amazon-corretto-${JAVA_AWS_VERSION}-linux-x64.tar.gz && \
	rm amazon-corretto-${JAVA_AWS_VERSION}-linux-x64.tar.gz \
	&& \
	wget -q https://dl.bintray.com/groovy/maven/apache-groovy-binary-3.0.4.zip -O groovy.zip && \
	unzip -q /groovy.zip -d . && \
	rm /groovy.zip \
	&& \
	wget -q https://us.mirrors.quenda.co/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -O maven.zip && \
	unzip -q /maven.zip -d . && \
	rm /maven.zip 

# COPY settings.xml $MVN_HOME/conf

ENV PATH="$PATH:$JAVA_HOME/bin:$GROOVY_HOME/bin:$MVN_HOME/bin"