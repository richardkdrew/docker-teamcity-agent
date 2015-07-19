# DOCKER-VERSION 1.6.2

FROM java:8-jre

MAINTAINER Richard Drew <richardkdrew@gmail.com>

# create user and group first
RUN groupadd -g 999 teamcity \
    && useradd -u 999 -g teamcity -m teamcity \
    && mkdir -p /opt/TeamCity \
    && chown teamcity:teamcity /opt/TeamCity \
# install dependencies
    && apt-get update \
    && apt-get install -y --no-install-recommends \
#        build-essential \
        git \
#        curl \
# install NodeJS, GruntJS and Bower
#    && curl -sL https://deb.nodesource.com/setup | bash - \
#    && apt-get install -y nodejs \
#    && npm install -g bower \
#    && npm install -g grunt-cli  \
# do some clean-up
    && apt-get -y autoremove \
    && apt-get clean
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# run the TeamCity Agent
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

USER teamcity

VOLUME ["/home/teamcity"]

ENTRYPOINT ["/docker-entrypoint.sh"]