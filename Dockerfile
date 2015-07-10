# DOCKER-VERSION 1.6.2

FROM java:8-jre

MAINTAINER Richard Drew <richardkdrew@gmail.com>

RUN groupadd -g 999 teamcity \
    && useradd -u 999 -g teamcity -m teamcity \
    && mkdir -p /opt/TeamCity && chown teamcity:teamcity /opt/TeamCity

USER teamcity

COPY runAgent /opt/TeamCity/

VOLUME ["/home/teamcity"]

CMD ["/opt/TeamCity/runAgent"]