# rtmp

在安装docker后执行如下命令：
```
docker build -t rtmp . && docker run -d -p 1935:1935 -p 8080:8080 --name rtmp rtmp
```
所有视频文件存放
```
# 直播目录
/data 
/data/hls/{appname}
/data/hls_low/{appname}
# 回放目录
/data/record/{appname}-{timestamp}.flv
/data/record/{appname}-{timestamp}.mp4
```
推流地址
```
rtmp://localhost/live/{appname}
```
hls地址
```
http://localhost:8080/live/{appname}/index.m3u8 
http://localhost:8080/hls/{appname}/index.m3u8 #转码后的地址
```
