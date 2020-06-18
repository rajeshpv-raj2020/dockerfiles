FROM rpradesh/scala:2.12.8

LABEL Maintainer="rao.rajesh8@gmail.com"

ARG SPARK_VERSION=2.4.6
ENV SPARK_HOME=/spark-${SPARK_VERSION}-bin-hadoop2.7 \
    PATH="$SPARK_HOME/bin:$PATH"

EXPOSE 7077 8077 8051-8060

ADD https://apache.cs.utah.edu/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz /spark-2.4.6-bin-hadoop2.7.tgz
COPY entrypoint.sh /entrypoint.sh
COPY files/BrowseHere.jar /BrowseHere.jar

RUN	cd / && mkdir /spark && \    
    tar xfz spark-2.4.6-bin-hadoop2.7.tgz -C . && \
	rm spark-2.4.6-bin-hadoop2.7.tgz && \
    chmod u+rx /entrypoint.sh 

VOLUME /spark

WORKDIR $SPARK_HOME

ENTRYPOINT ["/entrypoint.sh"]