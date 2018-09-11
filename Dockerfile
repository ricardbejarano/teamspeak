FROM debian:stretch AS build

ARG TEAMSPEAK_VERSION="3.3.1"
ARG TEAMSPEAK_CHECKSUM="b3891341a9ff4c4b6b0173ac57f1d64d4752550c95eeb26d2518ac2f5ca9fbc1"

ADD http://dl.4players.de/ts/releases/$TEAMSPEAK_VERSION/teamspeak3-server_linux_amd64-$TEAMSPEAK_VERSION.tar.bz2 /teamspeak.tar.bz2
RUN if [ "$TEAMSPEAK_CHECKSUM" != "$(sha256sum teamspeak.tar.bz2 | awk '{print $1}')" ]; then exit 1; fi && \
    apt update && \
    apt install -y lbzip2 && \
    tar xf teamspeak.tar.bz2


FROM gcr.io/distroless/base

COPY --from=build /teamspeak3-server_linux_amd64/ts3server /
COPY --from=build /teamspeak3-server_linux_amd64/sql /sql
COPY --from=build /teamspeak3-server_linux_amd64/libts3_ssh.so /teamspeak3-server_linux_amd64/libts3db_sqlite3.so /lib/

ENV LD_LIBRARY_PATH="/lib"
ENV TS3SERVER_LICENSE="accept"

CMD ["/ts3server"]
