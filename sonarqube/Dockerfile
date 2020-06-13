FROM rpradesh/javamvn:11.0.7

EXPOSE 9000

RUN groupadd -r sonarqube && useradd -r -g sonarqube sonarqube

ARG SONARQUBE_VERSION=8.2.0.32929
ARG SONARQUBE_ZIP_URL=https://binaries.sonarsource.com/CommercialDistribution/sonarqube-developer/sonarqube-developer-${SONARQUBE_VERSION}.zip
ENV SONAR_VERSION=${SONARQUBE_VERSION} 
ENV SONARQUBE_HOME=/sonarqube

RUN cd /   \
    && curl -o sonarqube.zip -fsSL "$SONARQUBE_ZIP_URL" \
    && unzip -q sonarqube.zip \
    && mv "sonarqube-${SONARQUBE_VERSION}" sonarqube \
    && rm sonarqube.zip* \
    && chown --recursive sonarqube:sonarqube "$SONARQUBE_HOME" 

WORKDIR $SONARQUBE_HOME

VOLUME /scanroot

COPY *.sh "$SONARQUBE_HOME/bin/"

RUN alias ll='ls -al' && \
    chown --recursive sonarqube:sonarqube "/etc" && \
    chown sonarqube:sonarqube /*.sh && \
    chown --recursive sonarqube:sonarqube "$SONARQUBE_HOME/bin" && \
    chmod u+rx /*.sh && chmod u+rx $SONARQUBE_HOME/bin/*.sh

ENV PATH="$PATH:$SONARQUBE_HOME/bin"

USER sonarqube

ENTRYPOINT ["/sonarqube/bin/entrypoint.sh"]
