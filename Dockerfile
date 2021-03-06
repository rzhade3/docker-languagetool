FROM debian:stretch

MAINTAINER Rahul Zhade <rahul@zhade.dev>

RUN set -ex \
    && mkdir -p /uploads /etc/apt/sources.list.d /var/cache/apt/archives/ \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get clean \
    && apt-get update -y \
    && apt-get install -y \
        bash \
        openjdk-8-jre-headless \
        python3-minimal \
        unzip

ENV LANG "C.UTF-8"
ENV VERSION 4.9.1

ADD https://www.languagetool.org/download/LanguageTool-$VERSION.zip /LanguageTool-$VERSION.zip
# We can also use a local version, if one has the local version cached
# ADD cache/LanguageTool-4.9.1.zip /LanguageTool-$VERSION.zip

RUN unzip /LanguageTool-$VERSION.zip \
    && mv /LanguageTool-$VERSION /LanguageTool \
    && rm /LanguageTool-$VERSION.zip

ADD misc/entrypoint.sh /entrypoint.sh
ADD misc/parse_log.py /parse_log.py
RUN chmod a+x /entrypoint.sh
RUN mkdir /nonexistent && touch /nonexistent/.languagetool.cfg

ENTRYPOINT ["/entrypoint.sh"]
