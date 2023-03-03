go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
~/go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
#编译caddy
cp caddy /usr/bin/
/usr/bin/caddy version
#查看caddy版本，是否安装成功
setcap cap_net_bind_service=+ep /usr/bin/caddy
#使用setcap命令设置 /usr/bin/caddy 可以非ROOT用户启动1024以下端口

mkdir /etc/caddy/
#创建caddy文件夹

cat <<EOF >> /etc/caddy/Caddyfile
:443, orbit1024.top
tls /etc/letsencrypt/live/orbit1024.top/fullchain.pem /etc/letsencrypt/live/orbit1024.top/privkey.pem
route {
  forward_proxy {
    basic_auth 123 123
    hide_ip
    hide_via
    probe_resistance
  }
  file_server {
    root /var/www/html 
  }
}
EOF
#创建并填写caddy配置文件

caddy fmt --overwrite /etc/caddy/Caddyfile
#格式化caddy文件
caddy run --config /etc/caddy/Caddyfile
#启动caddy

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
#创建naive启动文件

systemctl daemon-reload
systemctl enable naive
systemctl start naive
systemctl status naive
#开机自启动

