FROM ubuntu:14.04

ENV REFRESEHED_AT 2015-02-05

RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-dev libtool automake bison libsnmp-dev \
    libsnmp30

RUN mkdir /src
ADD . /src

RUN cd /src; ./autogen.sh; ./configure; make install

WORKDIR /data
VOLUME /data

RUN apt-get remove --purge  -y build-essential \
    libglib2.0-dev libtool automake bison libsnmp-dev \
    && apt-get clean autoclean && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}


ENTRYPOINT ["docsis"]
CMD ["--help"]
