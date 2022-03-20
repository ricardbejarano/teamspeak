<div align="center">
	<p><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/325/headphone_1f3a7.png" width="100px"></p>
	<h1>teamspeak</h1>
	<p>Built-from-source container image of <a href="https://www.teamspeak.com/en/">TeamSpeak</a></p>
	<code>docker pull quay.io/ricardbejarano/teamspeak</code>
</div>


## Features

* Pulled from official sources during build time
* Built `FROM scratch`, with zero bloat
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Tags

### Docker Hub

Available on Docker Hub as [`docker.io/ricardbejarano/teamspeak`](https://hub.docker.com/r/ricardbejarano/teamspeak):

- [`3.13.6`, `latest` *(Dockerfile)*](Dockerfile)

### RedHat Quay

Available on RedHat Quay as [`quay.io/ricardbejarano/teamspeak`](https://quay.io/repository/ricardbejarano/teamspeak):

- [`3.13.6`, `latest` *(Dockerfile)*](Dockerfile)


## Configuration

### Volumes

- Mount your **database** at `/data/ts3server.sqlitedb`

***Note:** do not mount at `/data`, you will override some runtime dependencies.*
