FROM debian:stretch AS build

ARG TEAMSPEAK_VERSION="3.5.0"
ARG TEAMSPEAK_CHECKSUM="9bd56e115afea19351a6238a670dc93e365fe88f8a6c28b5b542ef6ae2ca677e"

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
