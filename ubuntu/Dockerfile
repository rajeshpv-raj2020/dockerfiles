FROM ubuntu:20.04 as utcBuilder

LABEL Maintainer="rao.rajesh8@gmail.com"

WORKDIR /

ENV DEBIAN_FRONTEND=noninteractive \
    INITRD=No \
    LANG=en_US.UTF-8 \
    TZ_FILENAME=UTC

RUN apt-get update \
    && \
    apt-get install -y \
    --no-install-recommends \
    software-properties-common \
    gnupg2 locales wget curl sudo net-tools zip unzip \
    && \
    touch /usr/share/locale/locale.alias locale-gen en_US en_US.UTF-8 \
    && \
    apt-get clean  

COPY entrypoint.sh /entrypoint.sh
COPY setTimeZone.sh /setTimeZone.sh
COPY --from=rpradesh/faketime:1.0.0  /lib/faketime.so /lib/faketime.so

RUN alias ll='ls -al' && chmod u+rx /entrypoint.sh && chmod u+rx /setTimeZone.sh

ENTRYPOINT ["/entrypoint.sh"] 