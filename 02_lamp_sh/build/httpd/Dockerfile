FROM httpd:2.4-buster

LABEL Name="httpd"
LABEL Version="2.4"

ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update -y && apt-get -y install libapache2-mod-auth-kerb curl

RUN mkdir -p /usr/local/apache2/conf/extra/add_conf

ADD ./add_conf /usr/local/apache2/conf/extra/add_conf
RUN echo 'Include conf/extra/add_conf/*.conf' >> /usr/local/apache2/conf/httpd.conf
# ADD ./httpd/httpd.conf /usr/local/apache2/conf/httpd.conf

ENV LANG=pl_PL.utf8

# HEALTHCHECK --interval=1m --timeout=10s --start-period=5m CMD curl --fail http://localhost:80 || exit 1 
