<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/speech-balloon_1f4ac.png" width="120px"></p>
<h1 align="center">teamspeak (container image)</h1>
<p align="center">Minimal container image of the <a href="https://teamspeak.com/en/">TeamSpeak voice chat server</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/teamspeak`](https://hub.docker.com/r/ricardbejarano/teamspeak):

- [`3.10.1-glibc`, `3.10.1`, `glibc`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile.glibc)
- [`3.10.1-musl`, `musl` *(Dockerfile.musl)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile.musl)

### Quay

Available on [Quay](https://quay.io) as:

- [`quay.io/ricardbejarano/teamspeak-glibc`](https://quay.io/repository/ricardbejarano/teamspeak-glibc), tags: [`3.10.1`, `master`, `latest` *(Dockerfile.glibc)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile.glibc)
- [`quay.io/ricardbejarano/teamspeak-musl`](https://quay.io/repository/ricardbejarano/teamspeak-musl), tags: [`3.10.1`, `master`, `latest` *(Dockerfile.musl)*](https://github.com/ricardbejarano/teamspeak/blob/master/Dockerfile.musl)


## Features

* Super tiny (`glibc`-based image is about `20.4MB`, `musl`-based image is about `16.3MB`)
* Binary pulled from official sources during build time
* Built `FROM scratch`, with zero bloat (see [Filesystem](#filesystem))
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Configuration

### Volumes

- Mount your **database** at `/data/ts3server.sqlitedb`

***Note:** do not mount at `/data`, you would override some runtime dependencies.*


## Building

- To build the `glibc`-based image: `$ docker build -t teamspeak:glibc -f Dockerfile.glibc .`
- To build the `musl`-based image: `$ docker build -t teamspeak:musl -f Dockerfile.musl .`


## Filesystem

### `glibc`

Based on the [glibc](https://www.gnu.org/software/libc/) implementation of `libc`.

```
/
├── data/
│   └── sql/
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
│   ├── libts3db_mariadb.so
│   └── libts3db_sqlite3.so
├── lib64/
│   └── ld-linux-x86-64.so.2
└── ts3server
```

### `musl`

Based on the [musl](https://www.musl-libc.org/) implementation of `libc`.

```
/
├── data/
│   └── sql/
│       └── ...
├── etc/
│   ├── group
│   ├── passwd
│   └── ssl/
│       └── certs/
│           └── ca-certificates.crt
├── lib/
│   ├── ld-musl-x86_64.so.1
│   ├── libgcc_s.so.1
│   ├── libstdc++.so.6
│   ├── libts3_ssh.so
│   ├── libts3db_mariadb.so
│   └── libts3db_sqlite3.so
└── ts3server
```


## License

See [LICENSE](https://github.com/ricardbejarano/teamspeak/blob/master/LICENSE).
