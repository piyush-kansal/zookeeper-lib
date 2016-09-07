FROM ubuntu:xenial-20160818
FROM python:2.7.12

ARG VERSION=3.4.9
ARG MIRROR=http://apache.mirrors.pair.com

LABEL name="zookeeper-lib" version=$VERSION

RUN wget -q -O - $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$VERSION /opt/zookeeper \
    && apt-get update \
    && apt-get install -y dh-autoreconf \
    && apt-get install -y libcppunit-dev \
    && apt-get install -y python-setuptools \
    && apt-get install -y ant \
    && apt-get install -y python2.7-dev \
    && cd /opt/zookeeper/src/c \
    && ACLOCAL="aclocal -I /usr/share/aclocal" autoreconf -if \
    && ./configure --disable-shared --enable-static --with-pic \
    && make \
    && cd ../contrib/zkpython/ \
    && ant compile
