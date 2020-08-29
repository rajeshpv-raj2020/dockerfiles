FROM rpradesh/openjdk8

ARG H2_VERSION=1.4.200

ENV DB_NAME=test_db \
 DB_USER=h2user \
 DB_PWD=h2pwd \
 TCP_PORT=9032 \
 WEB_PORT=8032

EXPOSE $TCP_PORT
EXPOSE $WEB_PORT
VOLUME /h2
WORKDIR /

# Run is kept in sep line to make use of build cache
RUN wget -q https://repo1.maven.org/maven2/com/h2database/h2/${H2_VERSION}/h2-${H2_VERSION}.jar -O /h2.jar

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+rx /entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"] 