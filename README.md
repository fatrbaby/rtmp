# rtmp
```shell
docker build -t rtmp . && docker run -d -p 1935:1935 -p 8081:8080 --name rtmp rtmp
```

推流地址 http://localhost/live/{appname}
hls地址 http://localhost/hls/{appname}/index.m3u8
