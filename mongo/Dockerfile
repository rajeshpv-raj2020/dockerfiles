FROM ubuntu:16.04 as baseBuilder

LABEL Maintainer="rao.rajesh8@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive \
    INITRD=No \
    LANG=en_US.UTF-8 \
    LC_ALL=C \
    TZ_FILENAME=UTC

WORKDIR /

EXPOSE 27017

VOLUME /var/log/mongodb
VOLUME /var/lib/mongodb


RUN apt-get update \
    && \
    apt-get install -y \
    --no-install-recommends \
    software-properties-common \
    gnupg2 locales wget curl sudo net-tools zip unzip iputils-ping \
    && \
    touch /usr/share/locale/locale.alias locale-gen en_US en_US.UTF-8 

RUN wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | apt-key add - \    
    && echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
    && apt-get update \
    && apt-get install -y mongodb-org=3.2.22 mongodb-org-server=3.2.22 mongodb-org-shell=3.2.22 mongodb-org-mongos=3.2.22 mongodb-org-tools=3.2.22 \
    && apt-get clean 

COPY entrypoint.sh /entrypoint.sh
#COPY setTimeZone.sh /setTimeZone.sh

RUN chmod u+rx /entrypoint.sh 
    #&& chmod u+rx /setTimeZone.sh

ENTRYPOINT ["/entrypoint.sh"] 