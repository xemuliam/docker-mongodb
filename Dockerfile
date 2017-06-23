FROM       alpine:3.6
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        MONGODB_VERSION=3.4.4-r0
ARG        MONGODB_TOOLS_VERSION=3.4.4-r2
RUN        apk update && apk add --upgrade \
               bash \
               jq \
               mongodb=$MONGODB_VERSION \
               mongodb-tools=$MONGODB_TOOLS_VERSION && \
           rm -rf /var/cache/apk/*
RUN        mkdir -p /data/db /data/configdb && \
	   chown -R mongodb:mongodb /data/db /data/configdb
VOLUME     /data/db \
           /data/configdb
COPY       start_mongo.sh /usr/local/bin/
ENTRYPOINT [ "start_mongo.sh" ]
EXPOSE     27017 28017
CMD        [ "mongod" ]
