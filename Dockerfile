FROM debian AS build

ARG TEAMSPEAK_VERSION="3.9.0"
ARG TEAMSPEAK_CHECKSUM="4b945e9216b7627b015b47b6233f3a55c74e4d74701ae0aecf88f811fa098e99"

ADD https://files.teamspeak-services.com/releases/server/$TEAMSPEAK_VERSION/teamspeak3-server_linux_amd64-$TEAMSPEAK_VERSION.tar.bz2 /tmp/teamspeak.tar.bz2

RUN if [ "$TEAMSPEAK_CHECKSUM" != "$(sha256sum /tmp/teamspeak.tar.bz2 | awk '{print $1}')" ]; then exit 1; fi && \
    apt update && \
    apt install -y lbzip2 ca-certificates && \
    tar -C /tmp -xf /tmp/teamspeak.tar.bz2


FROM scratch

ENV LD_LIBRARY_PATH="/lib"
ENV TS3SERVER_LICENSE="accept"

COPY --from=build /lib/x86_64-linux-gnu/libc.so.6 \
                  /lib/x86_64-linux-gnu/libdl.so.2 \
                  /lib/x86_64-linux-gnu/libm.so.6 \
                  /lib/x86_64-linux-gnu/libpthread.so.0 \
                  /lib/x86_64-linux-gnu/librt.so.1 \
                  /lib/x86_64-linux-gnu/libgcc_s.so.1 \
                  /usr/lib/x86_64-linux-gnu/libstdc++.so.6 \
                  /lib/
COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /tmp/teamspeak3-server_linux_amd64/libts3_ssh.so \
                  /tmp/teamspeak3-server_linux_amd64/libts3db_sqlite3.so \
                  /lib/
COPY --from=build /tmp/teamspeak3-server_linux_amd64/sql /sql
COPY --from=build /tmp/teamspeak3-server_linux_amd64/ts3server /

EXPOSE 9987/udp 10011/tcp 30033/tcp
ENTRYPOINT ["/ts3server"]
