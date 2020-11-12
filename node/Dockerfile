FROM rpradesh/ubuntu

# install Nodejs 12 and typescript support
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && mkdir -p /usr/lib/node_modules \
    && apt -y install nodejs \
    && npm install -g typescript@3.9.7 @angular/cli@10.1.6 eslint@6.8.0
