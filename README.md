<p align=center><img src=https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/155/speech-balloon_1f4ac.png width=120px></p>
<h1 align=center>teamspeak (Docker image)</h1>
<p align=center>Minimal container image of the <a href=https://teamspeak.com/en/>TeamSpeak voice chat server</a></p>

Available at [`ricardbejarano/teamspeak`](https://hub.docker.com/r/ricardbejarano/teamspeak).


## Features

* Super tiny (only `16MB`)
* Built with the official Linux binary (available [here](https://teamspeak.com/en/your-download/#server))
* Based on the official `gcr.io/distroless/base` image


## Volumes

Mount your **ts3server.sqlitedb** and **ts3server.sqlitedb-wal** files on the container's `/ts3server.sqlitedb` and `/ts3server.sqlitedb-wal` paths, respectively, for server configuration persistency.


## License

See [LICENSE](https://github.com/ricardbejarano/teamspeak/blob/master/LICENSE).
