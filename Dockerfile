# DOCKER-VERSION 1.6.2
#
# TeamCity Agent (base) Dockerfile
#
# https://github.com/richardkdrew/docker-teamcity-agent
#

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
        git \
# do some clean-up
    && apt-get -y autoremove \
    && apt-get clean

# run the TeamCity Agent
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

USER teamcity

VOLUME ["/home/teamcity"]

ENTRYPOINT ["/docker-entrypoint.sh"]