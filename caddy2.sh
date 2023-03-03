#!/bin/bash
# 安装xcaddy工具
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# 使用xcaddy编译caddy并添加forwardproxy插件
~/go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive

# 将caddy二进制文件复制到/usr/bin/目录
cp caddy /usr/bin/

# 检查caddy版本
/usr/bin/caddy version

# 使用setcap命令设置 /usr/bin/caddy 可以非ROOT用户启动1024以下端口
setcap cap_net_bind_service=+ep /usr/bin/caddy

# 创建caddy配置文件目录
mkdir /etc/caddy/

# 创建caddy配置文件并添加内容
cat <<EOF >> /etc/caddy/Caddyfile
:443, 666.com
tls /etc/letsencrypt/live/666.com/fullchain.pem /etc/letsencrypt/live/666.com/privkey.pem
route {
  forward_proxy {
    basic_auth 123 123 # forwardproxy插件添加basic_auth认证
    hide_ip # 隐藏客户端IP地址
    hide_via # 隐藏Via头部
    probe_resistance # 添加探测抵抗功能
  }
  file_server {
    root /var/www/html # 添加file_server插件并指定根目录
  }
}
EOF

# 格式化caddy配置文件
caddy fmt --overwrite /etc/caddy/Caddyfile

# 启动caddy
caddy run --config /etc/caddy/Caddyfile

# 创建naive的systemd服务文件
cat <<EOF >> /etc/systemd/system/naive.service
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target
[Service]
Type=notify
User=root
Group=root
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_BIND_SERVICE
[Install]
WantedBy=multi-user.target
EOF

# 重新加载systemd配置文件
systemctl daemon-reload

# 设置naive服务开机自启动并启动服务
systemctl enable naive
systemctl start naive

# 查看naive服务状态
systemctl status naive
