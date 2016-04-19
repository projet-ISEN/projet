FROM tutum/apache-php

MAINTAINER miton18 <miton@rcdinfo.fr>

RUN apt-get update && apt-get install -yq nodejs-legacy git npm 

RUN rm -rf /var/lib/apt/lists/*

RUN rm -fr /app

ENV ALLOW_OVERRIDE=true

COPY . /app

WORKDIR /usr/local/bin/

RUN composer self-update

# composer install on api folder
WORKDIR /app/api/
RUN composer install


WORKDIR /app/public/
RUN npm -v
RUN npm install -g bower
RUN bower --allow-root install

EXPOSE 80 443