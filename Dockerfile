FROM alpine:latest
MAINTAINER ZhengYa <214598929@qq.com>
# nginx 版本
ENV NGINX_VERSION 1.11.8
# nginx_rtmp_module 版本
ENV NGINX_RTMP_MODULE_VERSION 1.2.1
# 依赖
RUN	apk update && \
	apk add \
		gcc \
		binutils-libs \
		binutils \
		gmp \
		isl \
		libgomp \
		libatomic \
		libgcc \
		openssl \
		pkgconf \
		pkgconfig \
		mpfr3 \
		mpc1 \
		libstdc++ \
		ca-certificates \
		libssh2 \
		curl \
		expat \
		pcre \
		musl-dev \
		libc-dev \
		pcre-dev \
		zlib-dev \
		openssl-dev \
		ffmpeg \
		make
# 创建文件夹
RUN mkdir -p /data/record && \
    mkdir -p /build/nginx && \
    mkdir -p /build/nginx-rtmp-module && \
    chmod -R 777 /data
# 下载 nginx nginx_rtmp_module 编译安装 nginx
RUN cd /build/nginx-rtmp-module && \
    wget -O nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.tar.gz https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_MODULE_VERSION}.tar.gz && \
    tar -zxf nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.tar.gz && \
    cd nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} && \
    cd /build/nginx && \
        wget -O nginx-${NGINX_VERSION}.tar.gz https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
        tar -zxf nginx-${NGINX_VERSION}.tar.gz && \
        cd nginx-${NGINX_VERSION} && \
    cd /build/nginx/nginx-${NGINX_VERSION} && \
    ./configure \
        --prefix=/opt/nginx \
        --with-http_ssl_module \
        --add-module=/build/nginx-rtmp-module/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} && \
    make && \
    make install
# 配置文件
COPY nginx.conf /opt/nginx/conf/nginx.conf
# 日志输出
RUN ln -sf /dev/stdout /opt/nginx/logs/access.log && \
    ln -sf /dev/stderr /opt/nginx/logs/error.log
EXPOSE 1935
EXPOSE 8080
CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
