# noVNC MetaTrader4
添加中文环境，修复中文显示乱码

<img src="https://raw.githubusercontent.com/zhonry/docker/docker-winbox/master/docker-winbox/screenshot/iShot_2023-07-01_14.32.45.png" width="400" /><img src="https://raw.githubusercontent.com/zhonry/docker/docker-winbox/master/docker-winbox/screenshot/iShot_2023-07-01_14.33.18.png" width="400" />



## 使用说明
挂载/opt/mt4/MQL4:/opt/MetaTrader4/MQL4目录，惯例EA、技术指标、脚本等
挂载/home/alpine/MetaTrader4/config目录，持久化保存MT4登陆信息
设置环境变量USERNAME和PASSWORD修改启动用户名和密码

### 命令行启动

```bash
docker pull jeesa/mt4
```

```bash
docker run --rm --name=mt4 -tid -p -p 5901:5900 -p 18081:8080 -v /opt/mt4/data:/root -v /opt/mt4/config:/opt/MetaTrader4/config -v /opt/mt4/MQL4:/opt/MetaTrader4/MQL4 -e USERNAME='username' -e PASSWORD='password' -e SCREEN_RESOLUTION='1440x900x24' jeesa/mt4
```


### docker-compose.yml启动

Example is [here](docker-compose.yml).

```yml
version: "3.3"

services:

mt4:
    image: jeesa/mt4
    container_name: mt4
    ports:
      - "5901:5900"
      - "18081:8080"
    volumes:
      - /opt/mt4/data:/root
      - /opt/mt4/MQL4:/opt/MetaTrader4/MQL4
      - /opt/mt4/config:/opt/MetaTrader4/config
    restart: always
    environment:
      - TZ=Asia/Shanghai
      - USERNAME='user'
      - PASSWORD='abc'
      - SCREEN_RESOLUTION='1440x900x24'
```

## 访问

VNC客户端访问5901端口或者浏览器访问IP+18081


