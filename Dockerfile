FROM debian:stretch AS build

ARG TEAMSPEAK_VERSION="3.5.1"
ARG TEAMSPEAK_CHECKSUM="aa991a7b88f4d6e24867a98548b808c093771b85443f986c8adb09e78e41eb79"

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
