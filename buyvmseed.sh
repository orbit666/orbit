#!/bin/sh

# 安装 sudo
apt-get install sudo &&
# 安装 xfsprogs
sudo apt-get install xfsprogs -y &&
# 安装 apparmor 和 apparmor-utils
apt install apparmor apparmor-utils -y &&
# 加载 xfs 模块
sudo modprobe -v xfs &&
# 禁用 swap 分区
swapoff -a &&
# 创建 swap 文件
dd if=/dev/zero of=/swap bs=1M count=6144 &&
# 修改 swap 文件权限
sudo chmod 600 /swap &&
# 格式化 swap 文件
mkswap /swap &&
# 激活 swap 文件
swapon /swap &&
# 将 swap 文件添加到 /etc/fstab 文件中
echo '/swap swap swap defaults 0 0' | sudo tee -a /etc/fstab &&
# 格式化 /dev/sda1 分区为 xfs 格式
mkfs.xfs -f /dev/sda1 &&
# 创建目录 /orbit123
mkdir /orbit123 &&
# 挂载 /dev/sda1 到 /orbit123
mount /dev/sda1 /orbit123 &&
# 更新软件包列表
apt update -y &&
# 升级软件包
apt upgrade -y &&
# 再次更新软件包列表
apt-get update &&
# 安装 vim, nano, sysstat, vnstat 和 curl
apt-get install vim nano sysstat vnstat curl -y &&
# 安装 curl
apt install curl -y &&
# 下载并运行 Docker 安装脚本
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh &&
# 创建文件夹 ~/docker/fb/config 和 ~/docker/fb/myfiles
mkdir -p ~/docker/fb/config ~/docker/fb/myfiles &&
# 运行 filebrowser 容器
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
# 再次更新软件包列表
apt update -y &&
# 再次升级软件包
apt upgrade -y &&
# 设置时区为上海
timedatectl set-timezone Asia/Shanghai &&
# 创建目录 /root/vertex
mkdir -p /root/vertex &&
# 设置目录 /root/vertex 的权限为 777
chmod 777 /root/vertex &&
# 运行 vertex 容器
docker run -d --name vertex --restart unless-stopped --network host -v /root/vertex:/vertex -e TZ=Asia/Shanghai lswl/vertex:stable &&
# 安装 Deluge
echo -e "y\n1\nn\nn\ny\n" | bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) orbit orbit 768 &&
# 安装 yabs
curl -sL yabs.sh | bash -s -- -i -g &&
# 输出 Vertex 的默认密码
echo -e "\033[32mVertex默认密码： $(cat vertex/data/password)\033[0m" &&
# 输出 Vertex 的默认账号
echo -e "\033[32mVertex： $(wget -qO- https://api.ipify.org):3000 默认账号：admin\033[0m" &&
# 输出 qbitorrent 的默认账号和密码
echo -e "\033[32mqbitorrent： $(wget -qO- https://api.ipify.org):8080 默认账号和密码相同：orbit\033[0m" &&
# 输出 FBE 的默认账号和密码
echo -e "\033[32mFBE： $(wget -qO- https://api.ipify.org):8082  默认账号和密码相同：admin\033[0m"






