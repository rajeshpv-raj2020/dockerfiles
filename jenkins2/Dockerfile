FROM rpradesh/openjdk8

# copied from https://github.com/jenkinsci/docker/blob/master/multiarch/Dockerfile.debian

RUN apt-get update && apt-get upgrade -y && apt-get install -y git curl dpkg gpg tar

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG JENKINS_HOME=/var/jenkins_home

ARG JENKINS_VERSION
ENV JENKINS_VERSION ${JENKINS_VERSION:-2.249.2}
# OLD 2.235.4 https://get.jenkins.io/war-stable/2.249.2/jenkins.war

ARG JENKINS_URL="https://get.jenkins.io/war-stable/${JENKINS_VERSION}/jenkins.war"

ENV JENKINS_HOME $JENKINS_HOME
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
ENV JAVA_HOME /amazon-corretto-8.272.10.3-linux-x64

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN mkdir -p $JENKINS_HOME \
  && chown ${uid}:${gid} $JENKINS_HOME \
  && groupadd -g ${gid} ${group} \
  && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades

VOLUME $JENKINS_HOME

RUN mkdir -p /usr/share/jenkins \
    && mkdir -p /usr/share/jenkins/ref \
    && chown -R ${user} "$JENKINS_HOME" /usr/share/jenkins/ref \
    && wget --no-check-certificate -q ${JENKINS_URL} -O /usr/share/jenkins/jenkins.war \
    && mkdir /app \
    && chown -R ${user}: /app \
    && alias ll='ls -al'

# install Mongo client 3.6 , since Debian 9 supports min of 3.6 nothing less than that
RUN apt install gnupg \
    && wget -qO - https://www.mongodb.org/static/pgp/server-3.6.asc | apt-key add -  \
    && echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list  \
        && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
        && mkdir -p /usr/lib/node_modules \
        && chown -R ${user}: /usr/lib/node_modules /usr/lib /usr/bin /usr/local \
    && apt update  \
        && apt-get -y install build-essential \
        && apt-get install -y mongodb-org-shell mongodb-org-tools \
        && apt-get -y install nodejs \
        && npm install -g typescript@3.9.7 @angular/cli@10.1.6 eslint nodemon ts-node

RUN cd / \
    && wget --no-check-certificate -q https://corretto.aws/downloads/latest/amazon-corretto-8-x64-linux-jdk.tar.gz -O /jdk.tgz \
    && tar xfz jdk.tgz \
    && rm -rf /jdk8u265-b01

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+rx /entrypoint.sh
    # && rm -rf /var/lib/apt/lists/*

# for main web interface:
EXPOSE ${http_port}

# will be used by attached slave agents:
EXPOSE ${agent_port}

ENV PATH="$JAVA_HOME/bin:$GROOVY_HOME/bin:$MVN_HOME/bin:$PATH:"

USER ${user}

WORKDIR $JENKINS_HOME

#ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "/usr/share/jenkins/jenkins.war"]
#ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/jenkins.war"]



ENTRYPOINT ["/entrypoint.sh"]