<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/speech-balloon_1f4ac.png" width="120px"></p>
<h1 align="center">teamspeak (container image)</h1>
<p align="center">Minimal container image of the <a href="https://teamspeak.com/en/">TeamSpeak</a> voice chat server</p>


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/teamspeak`](https://hub.docker.com/r/ricardbejarano/teamspeak):

- [`3.13.5`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/teamspeak`](https://quay.io/repository/ricardbejarano/teamspeak):

- [`3.13.5`, `latest` *(Dockerfile)*](Dockerfile)


## Features

* Pulled from official sources during build time
* Built `FROM scratch`, with zero bloat
* Dynamically linked to the [`musl`](https://musl.libc.org/) implementation of the C standard library
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build --tag ricardbejarano/teamspeak --file Dockerfile .
```


## Configuration

### Volumes

- Mount your **database** at `/data/ts3server.sqlitedb`

***Note:** do not mount at `/data`, you will override some runtime dependencies.*


## License

MIT licensed, see [LICENSE](LICENSE) for more details.
