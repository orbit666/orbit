#!/bin/bash

# 显示菜单选项
echo "请选择一项操作:"
echo -e "\033[1m\033[34m1. buyvm\033[0m"
echo "2. "\033[1m\033[34m1. lightsail\033[0m"
echo "3. "\033[1m\033[34m1. 退出\033[0m"

# 循环等待用户输入
while true; do
    read -p "请输入选项编号: " option

    # 验证用户输入是否有效
    if [[ "$option" =~ ^[1-3]$ ]]; then
        break
    else
        echo "选项无效，请重新输入。"
    fi
done

# 根据用户输入执行相应的.sh脚本
case "$option" in
    1)
        echo "正在安装buyvm的相关配置。"
        bash <(wget -qO- https://raw.githubusercontent.com/orbit666/orbit/master/figlet.sh)
        ;;
    2)
        echo "执行删除文件操作。"
        sh delete.sh
        ;;
    3)
        echo "退出脚本。"
        exit 0
        ;;
esac