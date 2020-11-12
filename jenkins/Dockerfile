FROM jenkins/jenkins:lts
# if we want to install via apt
USER root

# install Mongo client 3.6 , since Debian 9 supports min of 3.6 nothing less than that
RUN apt install gnupg \
    && wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | apt-key add -  \
    && echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list  \
        && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
        && mkdir -p /usr/lib/node_modules \
        && chown -R jenkins: /usr/lib/node_modules /usr/lib /usr/bin /usr/local \
    && apt update  \
    && apt -y install build-essential \
    && apt-get install -y mongodb-org-shell mongodb-org-tools \
        && apt -y install nodejs \
        && npm install -g typescript@3.9.7 @angular/cli@10.1.6 eslint nodemon ts-node

COPY entrypoint.sh /entrypoint.sh

RUN chmod u+rx /entrypoint.sh && chown -R jenkins: /entrypoint.sh \
    && mkdir /app \
    && chown -R jenkins: /app \
    && alias ll='ls -al'

USER jenkins

ENTRYPOINT ["/entrypoint.sh"]