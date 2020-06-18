FROM rpradesh/spark:2.4.6

LABEL Maintainer="rao.rajesh8@gmail.com"

COPY entrypoint.sh /entrypoint.sh
COPY shiro.ini /shiro.ini
COPY zeppelin-site.xml /zeppelin-site.xml
# ADD http://mirrors.gigenet.com/apache/zeppelin/zeppelin-0.8.2/zeppelin-0.8.2-bin-all.tgz /zeppelin.tgz

# RUN wget -q https://apache.cs.utah.edu/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz -O spark.tgz

ENV ZEPPELIN_HOME=/zeppelin
ENV PATH="$ZEPPELIN_HOME/bin:$PATH"

RUN  cd / && \
    wget -q http://mirrors.gigenet.com/apache/zeppelin/zeppelin-0.8.2/zeppelin-0.8.2-bin-all.tgz -O /zeppelin.tgz && \
    tar xfz /zeppelin.tgz -C . && \
    rm -f  /zeppelin.tgz && \
    mv /zeppelin-0.8.2-bin-all /zeppelin && \
    cp /shiro.ini $ZEPPELIN_HOME/conf && \
    cp /zeppelin-site.xml $ZEPPELIN_HOME/conf 

RUN mv $ZEPPELIN_HOME/notebook $ZEPPELIN_HOME/notebook-bak &&  \
    chmod u+rx /entrypoint.sh 
 
WORKDIR $ZEPPELIN_HOME

EXPOSE 9080

ENTRYPOINT ["/entrypoint.sh"]