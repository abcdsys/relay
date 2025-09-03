# 使用轻量级运行时镜像
FROM alpine:latest

# 设置清华源以加快下载速度
RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories

# 安装运行时依赖
RUN apk add --no-cache \
        bash \
        iproute2 \
        iputils \
        openssl \
        curl

# 设置工作目录
WORKDIR /root/

# 复制必要的文件 
COPY . . 
RUN chmod +x libressl.sh
RUN ./libressl.sh
# 复制已有的 psyduck 可执行文件
COPY psyduck .
RUN chmod +x ./psyduck
# 暴露端口
EXPOSE 24678

# 设置容器以NET_ADMIN权限运行
# 注意：实际运行时需要添加 --cap-add=NET_ADMIN 参数

# 启动应用
CMD ["./psyduck"]
