FROM ich777/debian-baseimage AS builder

LABEL org.opencontainers.image.authors="admin@minenet.at"

ARG ZNC_V="version"

RUN apt-get update && \
    apt-get -y install build-essential cmake git libssl-dev libsasl2-dev gettext libboost-all-dev pkg-config swig

RUN git clone https://github.com/znc/znc /tmp/znc && \
    cd /tmp/znc && \
    git checkout znc-${ZNC_V} && \
    git submodule update --init --recursive

RUN mkdir /tmp/znc/build && \
    cd /tmp/znc/build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j$(nproc -all) && \
    DESTDIR=/opt/znc make install -j$(nproc --all)

FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-znc"

RUN apt-get update && \
    apt-get -y install libicu67 libboost-locale1.74.0

COPY --from=builder /opt/znc/ /

ENV DATA_DIR="/znc"
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="znc"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
COPY /config/ /opt/

RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]