FROM debian:stretch AS build

ARG TEAMSPEAK_VERSION="3.4.0"
ARG TEAMSPEAK_CHECKSUM="7d6ec8e97d4a9e9913a7e01f2e7f5f9fddfdc41b11e668d013a0f4b574d1918b"

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
