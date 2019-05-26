<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/speech-balloon_1f4ac.png width=120px></p>
<h1 align=center>teamspeak (container image)</h1>
<p align=center>Minimal container image of the <a href=https://teamspeak.com/en/>TeamSpeak voice chat server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/teamspeak`](https://hub.docker.com/r/ricardbejarano/teamspeak):

- [`3.7.1`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/teamspeak`](https://quay.io/repository/ricardbejarano/teamspeak):

- [`3.7.1`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile)


## Features

* Super tiny (only `18.2MB`)
* Built with the official Linux binary (available [here](https://teamspeak.com/en/your-download/#server))
* Built from `scratch`, see the [Filesystem](#Filesystem) section below for an exhaustive list of the image's contents
* Reduced attack surface (no `bash`, no UNIX tools, no package manager...)


## Configuration

### Volumes

| Mountpoint              | Description                       |
|-------------------------|-----------------------------------|
| /ts3server.sqlitedb     | SQLite (database file)            |
| /ts3server.sqlitedb-wal | SQLite (write-ahead logging file) |
| /query_ip_blacklist.txt | ServerQuery IP blacklist          |
| /query_ip_whitelist.txt | ServerQuery IP whitelist          |
| /ssh_host_rsa_key       | SSH Host RSA key                  |
| /files                  | Server files                      |
| /logs                   | Log files                         |


## Filesystem

The images' contents are:

```
/
├── etc/
│   └── ssl/
│       └── certs/
│           └── ca-certificates.crt
├── lib/
│   ├── libc.so.6
│   ├── libdl.so.2
│   ├── libm.so.6
│   ├── libpthread.so.0
│   ├── librt.so.1
│   ├── libts3_ssh.so
│   └── libts3db_sqlite3.so
├── lib64/
│   └── ld-linux-x86-64.so.2
├── sql/
│   └──  ...
└── ts3server
```


## License

See [LICENSE](https://github.com/ricardbejarano/teamspeak/blob/master/LICENSE).
