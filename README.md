<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/speech-balloon_1f4ac.png width=120px></p>
<h1 align=center>teamspeak (container image)</h1>
<p align=center>Minimal container image of the <a href=https://teamspeak.com/en/>TeamSpeak voice chat server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/teamspeak`](https://hub.docker.com/r/ricardbejarano/teamspeak):

- [`3.9.0`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/teamspeak`](https://quay.io/repository/ricardbejarano/teamspeak):

- [`3.9.0`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile)


## Features

* Super tiny (`~20.4MB`)
* Binary pulled from official website
* Built `FROM scratch`, see [Filesystem](#filesystem) for an exhaustive list of the image's contents
* Reduced attack surface (no shell, no UNIX tools, no package manager...)


## Configuration

### Volumes

- `/data/ts3server.sqlitedb`: database file
- `/data/ts3server.sqlitedb-wal`: database WAL file
- `/data/query_ip_blacklist.txt`: ServerQuery IP blacklist
- `/data/query_ip_whitelist.txt`: ServerQuery IP whitelist
- `/data/ssh_host_rsa_key`: SSH host RSA key
- `/data/files`: server files
- `/data/logs`: logs


## Filesystem

The images' contents are:

```
/
├── data/
│   ├── .keep
│   └── sql/...
│       └── ...
├── etc/
│   ├── group
│   ├── passwd
│   └── ssl/
│       └── certs/
│           └── ca-certificates.crt
├── lib/
│   ├── libc.so.6
│   ├── libdl.so.2
│   ├── libgcc_s.so.1
│   ├── libm.so.6
│   ├── libpthread.so.0
│   ├── librt.so.1
│   ├── libstdc++.so.6
│   ├── libts3_ssh.so
│   └── libts3db_sqlite3.so
├── lib64/
│   └── ld-linux-x86-64.so.2
└── ts3server
```


## License

See [LICENSE](https://github.com/ricardbejarano/teamspeak/blob/master/LICENSE).
