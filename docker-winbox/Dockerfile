FROM alpine:latest

MAINTAINER zhanghz <zhz@honry.net>

ENV DISPLAY=":1"\
 LANG=zh_CN.UTF-8\
 LC_ALL=zh_CN.UTF-8

RUN echo http://mirrors.ustc.edu.cn/alpine/edge/testing >> /etc/apk/repositories

RUN apk add --no-cache --update netcat-openbsd busybox-extras sudo python3 git bash supervisor xvfb x11vnc openbox socat xterm wine \
  && git clone https://github.com/novnc/noVNC.git /opt/noVNC \
  && git clone https://github.com/kanaka/websockify /opt/noVNC/utils/websockify \
  && ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html \
  && mkdir -p /usr/share/fonts/TTF/ && mkdir -p /home/alpine/.wine/drive_c/users/alpine/AppData/Roaming/Mikrotik/Winbox/sessions/ \
  && rm -rf /opt/noVNC/.git \
  && rm -rf /opt/noVNC/utils/websockify/.git \
  && rm -fr /opt/noVNC/vnc_lite.html \
  && rm -rf /apk /tmp/* /var/cache/apk/*

RUN addgroup alpine \
  && adduser  -G alpine -s /bin/sh -D alpine \
  && echo "alpine    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN  wget -q -c -O /home/alpine/winbox64.exe "https://mt.lv/winbox64"
# For access via VNC
EXPOSE 5900

# For access via noVNC
EXPOSE 8080

COPY etc /etc
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY user-data /home/alpine
COPY desktop-1024x576.jpg /etc/xdg/openbox
COPY winbox.png /opt/noVNC
COPY vnc.html /opt/noVNC

# 复制中文字体
COPY fonts /usr/share/fonts/TTF/

RUN chown alpine:alpine -R /home/alpine

WORKDIR /home/alpine

# 挂载winbox配置文件夹
VOLUME /home/alpine/.wine/drive_c/users/alpine/AppData/Roaming/Mikrotik/Winbox

# User alpine
USER alpine

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
