FROM alpine:3 AS build

ARG VERSION="3.13.5"
ARG CHECKSUM="db70478d8b2d6358c0005504f1673e490ec0220b7ab93bdb418f0b051f4940aa"

ADD https://files.teamspeak-services.com/releases/server/$VERSION/teamspeak3-server_linux_alpine-$VERSION.tar.bz2 /tmp/teamspeak.tar.bz2

RUN [ "$(sha256sum /tmp/teamspeak.tar.bz2 | awk '{print $1}')" = "$CHECKSUM" ] && \
    apk add bzip2 libgcc libstdc++ ca-certificates && \
    tar -C /tmp -xf /tmp/teamspeak.tar.bz2

RUN mkdir -p /rootfs/bin && \
      cp /tmp/teamspeak3-server_linux_alpine/ts3server /rootfs/bin/ && \
    mkdir -p /rootfs/data && \
      cp -r /tmp/teamspeak3-server_linux_alpine/sql /rootfs/data/ && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd && \
    mkdir -p /rootfs/etc/ssl/certs && \
      cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/ && \
    mkdir -p /rootfs/lib && \
      cp \
        /lib/ld-musl-x86_64.so.1 \
        /usr/lib/libgcc_s.so.1 \
        /usr/lib/libstdc++.so.6 \
        /tmp/teamspeak3-server_linux_alpine/libts3_ssh.so \
        /tmp/teamspeak3-server_linux_alpine/libts3db_sqlite3.so \
        /tmp/teamspeak3-server_linux_alpine/libts3db_mariadb.so \
        /tmp/teamspeak3-server_linux_alpine/redist/libmariadb.so.2 \
        /rootfs/lib/


FROM scratch

ENV LD_LIBRARY_PATH="/lib"
ENV TS3SERVER_LICENSE="accept"

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
WORKDIR /data
EXPOSE 9987/udp 10011/tcp 30033/tcp
ENTRYPOINT ["/bin/ts3server"]
