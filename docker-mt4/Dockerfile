FROM ubuntu:jammy

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8

RUN apt-get update && apt-get install -y ca-certificates && \
    sed -i "s/http:\/\/archive.ubuntu.com/https:\/\/mirrors.ustc.edu.cn/g" /etc/apt/sources.list && \
    sed -i "s/http:\/\/security.ubuntu.com/https:\/\/mirrors.ustc.edu.cn/g" /etc/apt/sources.list && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y install python2 xvfb x11vnc xdotool wget curl tar supervisor fluxbox gnupg2 xz-utils  && \
    wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -  && \
    echo 'deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main' |tee /etc/apt/sources.list.d/winehq.list && \
    apt-get update && apt-get -y install winehq-stable && \
    apt-get -y full-upgrade && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget -O - https://github.com/novnc/noVNC/archive/v1.4.0.tar.gz | tar -xzv -C /opt/ && mv /opt/noVNC-1.4.0 /opt/novnc && ln -s /opt/novnc/vnc_lite.html /opt/novnc/index.html && \
    wget -O - https://github.com/novnc/websockify/archive/v0.11.0.tar.gz | tar -xzv -C /opt/ && mv /opt/websockify-0.11.0 /opt/novnc/utils/websockify && \
    mkdir -p /opt/MetaTrader4 && rm -rf /etc/X11/fluxbox/*
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY terminal.exe /opt/MetaTrader4
COPY fonts /usr/share/fonts/TTF/

WORKDIR /root/

ENV WINEPREFIX /root/wine32
ENV WINEARCH win32
ENV DISPLAY :0
ENV SCREEN_RESOLUTION 1440x900x24

EXPOSE 8080
VOLUME [ "/root" ]
VOLUME [ "/opt/MetaTrader4/config" ]
VOLUME [ "/opt/MetaTrader4/MQL4" ]

CMD ["/usr/bin/supervisord"]




