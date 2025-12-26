# noVNC Winbox
支持中文显示，中文输入法

<img src="https://raw.githubusercontent.com/ZHonry/docker/main/docker-winbox-V4/screenshot/iShot_2025-12-26_11.18.24.png" width="400" /><img src="https://raw.githubusercontent.com/ZHonry/docker/main/docker-winbox-V4/screenshot/iShot_2025-12-26_11.18.46.png" width="400" />



## 使用说明
设置环境变量USERNAME和PASSWORD修改启动用户名和密码

### 命令行启动

```bash
docker pull jeesa/winbox:latest-V4
```

```bash
docker run --rm --name=winbox -tid -p -p 5901:5900 -p 18081:8080 -e USERNAME='username' -e PASSWORD='password' jeesa/winbox:latest-V4
```


### docker-compose.yml启动

Example is [here](docker-compose.yml).

```yml
version: "3.3"

services:

  winbox:
    image: jeesa/winbox:latest-V4
    container_name: winbox
    restart: always
    ports:
      - "5901:5900"
      - "18081:8080"
    environment:
      - TZ=Asia/Shanghai
      - USERNAME='username'
      - PASSWORD='password'
```

## 访问

VNC客户端访问5901端口或者浏览器访问IP+18081


## Github
构建参考 [CNSoluciones](https://github.com/lordbasex/Docker)
