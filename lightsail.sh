#!/bin/sh
sudo apt-get update -y && sudo apt-get upgrade -y
echo root:orbit |sudo chpasswd root
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
#改root密码，并且设置可以密码登录

apt-get update && apt-get install vim nano sysstat vnstat curl -y
#安装vim和curl

wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
tar -zxvf go1.20.1.linux-amd64.tar.gz -C /usr/local/
#安装go
echo export PATH=$PATH:/usr/local/go/bin  >> /etc/profile
source /etc/profile
#添加变量
go version
#查看go版本

sudo apt install snapd -y
sudo snap install core
sudo snap refresh core
#安装snad


go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
~/go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
#编译caddy
cp caddy /usr/bin/
/usr/bin/caddy version
setcap cap_net_bind_service=+ep /usr/bin/caddy
#使用setcap命令设置 /usr/bin/caddy 可以非ROOT用户启动1024以下端口。

sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

mkdir -p ~/docker/fb/config ~/docker/fb/myfiles
docker run -d --name fb \
  --restart=unless-stopped \
  -e PUID=$UID \
  -e PGID=$GID \
  -e WEB_PORT=8082 \
  -e FB_AUTH_SERVER_ADDR="127.0.0.1" \
  -p 8082:8082 \
  -v ~/docker/fb/config:/config \
  -v /:/myfiles \
  --mount type=tmpfs,destination=/tmp \
  80x86/filebrowser:2.9.4-amd64

bash -c 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf'
bash -c 'echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf'
sysctl -p

sudo certbot certonly --standalone
#安装cerbot

