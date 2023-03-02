#!/bin/sh
apt-get install sudo &&
sudo apt-get install xfsprogs -y &&
apt install apparmor apparmor-utils -y &&
sudo modprobe -v xfs &&
apt update -y &&
apt upgrade -y &&
apt-get update && apt-get install vim nano sysstat vnstat curl -y &&
apt install curl -y &&
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
timedatectl set-timezone Asia/Shanghai &&
mkdir -p /root/vertex &&
chmod 777 /root/vertex &&
docker run -d --name vertex --restart unless-stopped --network host -v /root/vertex:/vertex -e TZ=Asia/Shanghai lswl/vertex:stable &&
echo -e "y\n1\nn\nn\ny\n" | bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) orbit orbit 4096 &&

echo -e "\033[32mVertex默认密码： $(cat vertex/data/password)\033[0m" &&
echo -e "\033[32mVertex： $(wget -qO- https://api.ipify.org):3000 默认账号：admin\033[0m" &&
echo -e "\033[32mqbitorrent： $(wget -qO- https://api.ipify.org):8080 默认账号和密码相同：orbit\033[0m" &&
echo -e "\033[32mFBE： $(wget -qO- https://api.ipify.org):8082  默认账号和密码相同：admin\033[0m"




