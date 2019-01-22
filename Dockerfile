FROM debian:stretch AS build

ARG TEAMSPEAK_VERSION="3.6.0"
ARG TEAMSPEAK_CHECKSUM="5a0ed8229c0c8f071b85b1ac02a7176562b6386dae66babfaa553d5da26386be"

WORKDIR /tmp
ADD http://dl.4players.de/ts/releases/$TEAMSPEAK_VERSION/teamspeak3-server_linux_amd64-$TEAMSPEAK_VERSION.tar.bz2 /tmp/teamspeak.tar.bz2
RUN if [ "$TEAMSPEAK_CHECKSUM" != "$(sha256sum /tmp/teamspeak.tar.bz2 | awk '{print $1}')" ]; then exit 1; fi && \
    apt update && \
    apt install -y lbzip2 && \
    tar xf /tmp/teamspeak.tar.bz2


FROM gcr.io/distroless/base

ENV LD_LIBRARY_PATH="/lib"
ENV TS3SERVER_LICENSE="accept"

COPY --from=build /tmp/teamspeak3-server_linux_amd64/ts3server /ts3server
COPY --from=build /tmp/teamspeak3-server_linux_amd64/sql /sql
COPY --from=build \
     /tmp/teamspeak3-server_linux_amd64/libts3_ssh.so \
     /tmp/teamspeak3-server_linux_amd64/libts3db_sqlite3.so \
     /lib/

ENTRYPOINT ["/ts3server"]
