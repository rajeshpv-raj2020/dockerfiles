FROM centos:centos7

ARG MONGO_VER=3.2

ENV REPO_FILEPATH=/etc/yum.repos.d/mongodb-org-${MONGO_VER}.repo

RUN echo -e "[mongodb-org-4.0] \n\
name=MongoDB Repository \n\
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/ \n\
gpgcheck=1 \n\
enabled=1 \n\
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc\
" > ${REPO_FILEPATH}

RUN cat ${REPO_FILEPATH} \
    && echo ${REPO_FILEPATH} \
    && sed -i "s|4.0|${MONGO_VER}|g" ${REPO_FILEPATH} \
    && cat ${REPO_FILEPATH} \
    && yum install -y mongodb-org-shell mongodb-org-tools


