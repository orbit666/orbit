#!/bin/sh
echo root:orbit |sudo chpasswd root &&
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config &&
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config &&

apt-get update && apt-get install vim nano sysstat vnstat curl -y &&
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh &&
mkdir -p ~/docker/fb/config ~/docker/fb/myfiles &&
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
  80x86/filebrowser:2.9.4-amd64 &&
apt update -y &&
apt upgrade -y &&
apt install apparmor apparmor-utils -y &&
apt install curl -y &&
curl -fsSL https://get.docker.com -o get-docker.sh &&
sh get-docker.sh &&
timedatectl set-timezone Asia/Shanghai &&
mkdir -p /root/vertex &&
chmod 777 /root/vertex &&
docker run -d --name vertex --restart unless-stopped --network host -v /root/vertex:/vertex -e TZ=Asia/Shanghai lswl/vertex:stable &&
echo -e "y\n1\nn\nn\ny\n" | bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) orbit orbit 4096 &&

cat vertex/data/password

