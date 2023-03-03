#!/bin/sh
sudo apt-get update -y && sudo apt-get upgrade -y
echo root:password |sudo chpasswd root
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
#改root密码，并且设置可以密码登录,将上面的psaaword改成自己想要的root密码

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

bash <(wget -qO- https://raw.githubusercontent.com/orbit666/orbit/master/caddy.sh)
#安装并配置caddy

sudo apt install snapd -y
sudo snap install core
sudo snap refresh core
#安装snad

sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
#安装cerbot用来获取证书 
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
#安装docker

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
  #安装FBE

bash -c 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf'
bash -c 'echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf'
sysctl -p
#启用bbr

sudo certbot certonly --standalone
#运行cerbot

