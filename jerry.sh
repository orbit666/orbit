#!/bin/bash

echo "请输入用户名称："
read admin

echo "请输入用户密码："
read password

echo "请输入缓存大小(单位:MiB)："
read cache_size

bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) "$admin" "$password" "$cache_size"
