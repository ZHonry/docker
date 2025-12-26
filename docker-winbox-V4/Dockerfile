# 基础镜像：Debian Bookworm（自带 glibc）
FROM debian:bookworm-slim

# 语言与时区环境
ENV DISPLAY=":1" \
    LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai

# 更新系统并安装必需依赖

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates wget unzip sudo bash git python3 supervisor xvfb x11vnc openbox socat xterm \
        libgtk-3-0 libxcb1 libx11-6 libxrandr2 libxcursor1 libxrender1 \
        libxkbcommon0 libxkbcommon-x11-0 libxml2 libxcb-util1 libxcb-icccm4 libxcb-keysyms1 \
        libxcb-image0 libxcb-shape0 libxcb-render-util0 fonts-dejavu fonts-noto-cjk net-tools \
        novnc websockify \
        libegl1 libgl1 libgles2 libglvnd0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# 设置 UTF-8 字体（中文支持）
# 设置 UTF-8 字体（中文支持）
RUN echo "deb http://mirrors.ustc.edu.cn/debian bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/debian bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y locales fonts-noto-cjk && \
    sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=zh_CN.UTF-8



# Clone noVNC 并配置快捷入口
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/kanaka/websockify /opt/noVNC/utils/websockify && \
    ln -sf /opt/noVNC/vnc.html /opt/noVNC/index.html && \
    rm -rf /opt/noVNC/.git /opt/noVNC/utils/websockify/.git
# 修改 vnc.html 标题与 logo
RUN sed -i 's/<title>noVNC<\/title>/<title>winbox<\/title>/' /opt/noVNC/vnc.html && \
    sed -i 's/<p class="noVNC_logo" translate="no"><span>no<\/span>VNC<\/p>/<div align="center" style="box-shadow:none;background-color:#00000000;"><img src="winbox.png" width="50%"><\/div>\n        <p class="noVNC_logo" translate="no"><span>win<\/span>box<\/p>/' /opt/noVNC/vnc.html

# 创建普通用户 winbox
RUN useradd -m -s /bin/bash winbox && echo "winbox ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 下载原生 Linux 版 WinBox（无需 wine）
RUN wget -q -O /home/winbox/WinBox_Linux.zip "https://download.mikrotik.com/routeros/winbox/4.0beta44/WinBox_Linux.zip" && \
    unzip /home/winbox/WinBox_Linux.zip -d /home/winbox/ && \
    rm -f /home/winbox/WinBox_Linux.zip && \
    chmod +x /home/winbox/WinBox

# 拷贝配置、资源
COPY etc /etc
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY desktop-1024x576.jpg /etc/xdg/openbox/
COPY winbox.png /opt/noVNC/
COPY fonts /usr/share/fonts/truetype/custom/

# 修正权限
RUN chown -R winbox:winbox /home/winbox /opt/noVNC

# 设置默认工作目录与用户
USER winbox
WORKDIR /home/winbox

# 暴露端口（VNC + noVNC）
EXPOSE 5900 8080

# 使用 Supervisor 管理多进程
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
