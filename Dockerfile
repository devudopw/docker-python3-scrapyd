# Dockerfile for scraypd
# http://scrapyd.readthedocs.org/en/latest/

FROM ubuntu:14.04

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 627220E7
RUN echo 'deb http://archive.scrapy.org/ubuntu scrapy main' > /etc/apt/sources.list.d/scrapy.list
RUN apt-get update -qq
RUN apt-get install python3-pip python3-dev libxml2-dev libxslt-dev libz-dev libssl-dev -y
RUN pip3 install --upgrade setuptools
RUN pip3 install scrapyd w3lib lxml cssselect
RUN apt-get autoremove && apt-get clean
RUN sed -i 's/127.0.0.1/0.0.0.0/' /usr/local/lib/python3.4/dist-packages/scrapyd/default_scrapyd.conf

# Expose scrapyd default port
EXPOSE 6800

VOLUME ["/var/lib/scrapyd"]
VOLUME ["/var/log/scrapyd"]

# Set scrapyd as run entrypoint
CMD ["/usr/local/bin/scrapyd"]
