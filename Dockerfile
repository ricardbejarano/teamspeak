FROM debian AS build

ARG TEAMSPEAK_VERSION="3.7.1"
ARG TEAMSPEAK_CHECKSUM="6787d4c9fd6f72d1386872a61f38f932a8ee745046b1497168286ffd0311c0f0"

ADD http://dl.4players.de/ts/releases/$TEAMSPEAK_VERSION/teamspeak3-server_linux_amd64-$TEAMSPEAK_VERSION.tar.bz2 /tmp/teamspeak.tar.bz2

RUN cd /tmp && \
      if [ "$TEAMSPEAK_CHECKSUM" != "$(sha256sum /tmp/teamspeak.tar.bz2 | awk '{print $1}')" ]; then exit 1; fi && \
      apt update && \
      apt install -y lbzip2 ca-certificates && \
      tar xf /tmp/teamspeak.tar.bz2


FROM scratch

ENV LD_LIBRARY_PATH="/lib"
ENV TS3SERVER_LICENSE="accept"

COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 \
                  /lib/x86_64-linux-gnu/libdl.so.2 \
                  /lib/x86_64-linux-gnu/libm.so.6 \
                  /lib/x86_64-linux-gnu/libpthread.so.0 \
                  /lib/x86_64-linux-gnu/librt.so.1 \
                  /lib/
COPY --from=build /lib64/ld-linux-x86-64.so.2 \
                  /lib64/
COPY --from=build /etc/ssl/certs/ca-certificates.crt \
                  /etc/ssl/certs/
COPY --from=build /tmp/teamspeak3-server_linux_amd64/libts3_ssh.so \
                  /tmp/teamspeak3-server_linux_amd64/libts3db_sqlite3.so \
                  /lib/
COPY --from=build /tmp/teamspeak3-server_linux_amd64/sql /sql
COPY --from=build /tmp/teamspeak3-server_linux_amd64/ts3server /ts3server

ENTRYPOINT ["/ts3server"]
