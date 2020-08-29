FROM rpradesh/ubuntu:20.04.0

ENV GROOVY_HOME=/groovy-3.0.4 \
MVN_HOME=/apache-maven-3.6.3 \
JAVA_HOME=/jdk8u265-b01 \
PROJECTS_HOME=/projects

WORKDIR /

RUN mkdir -p $PROJECTS_HOME && mkdir -p /M2-REPO && mkdir -p $MVN_HOME/conf \
	&& \
	wget --no-check-certificate -q  \
    https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jdk_x64_linux_hotspot_8u265b01.tar.gz && \
	tar xfz OpenJDK8U-jdk_x64_linux_hotspot_8u265b01.tar.gz && \
	rm OpenJDK8U-jdk_x64_linux_hotspot_8u265b01.tar.gz && \
	rm $JAVA_HOME/src.zip \
	&& \
	wget -q https://dl.bintray.com/groovy/maven/apache-groovy-binary-3.0.4.zip -O groovy.zip && \
	unzip -q /groovy.zip -d . && \
	rm /groovy.zip \
	&& \
	wget -q https://us.mirrors.quenda.co/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -O maven.zip && \
	unzip -q /maven.zip -d . && \
	rm /maven.zip 

# COPY settings.xml $MVN_HOME/conf

ENV LC_ALL=C
RUN echo 'LANG="en_US.UTF-8"' >> /etc/default/locale
RUN echo 'LANGUAGE="en_US"' >> /etc/default/locale
RUN echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale


ENV PATH="$PATH:$JAVA_HOME/bin:$GROOVY_HOME/bin:$MVN_HOME/bin"
