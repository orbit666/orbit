echo "
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
}" > /etc/caddy/Caddyfile

caddy fmt --overwrite /etc/caddy/Caddyfile
caddy run --config /etc/caddy/Caddyfile


echo "[Unit]
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
WantedBy=multi-user.target" > /etc/systemd/system/naive.service

systemctl daemon-reload
systemctl enable naive
systemctl start naive
systemctl status naive

