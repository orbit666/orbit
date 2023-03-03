#!/bin/bash

# 显示菜单选项
echo "请选择一项操作:"
echo -e "\033[1m\033[34m1.jerry脚本,自定义选项\033[0m"
echo -e "\033[1m\033[34m2.yabs vps测试脚本\033[0m"
echo -e "\033[1m\033[34m3.看看色图\033[0m"
echo -e "\033[1m\033[34m4.退出\033[0m"


# 循环等待用户输入
while true; do
    read -p "请输入选项编号: " option

    # 验证用户输入是否有效
    if [[ "$option" =~ ^[1-4]$ ]]; then
        break
    else
        echo "选项无效，请重新输入。"
    fi
done

# 根据用户输入执行相应的.sh脚本
case "$option" in
    1)
        echo "正在执行jerry脚本"
        bash <(wget -qO- https://raw.githubusercontent.com/orbit666/orbit/master/jerry.sh)
        ;;
    2)
        echo "yabs测速"
        curl -sL yabs.sh | bash
        ;;
    3)
        echo "色图来喽"
        bash <(wget -qO- https://raw.githubusercontent.com/orbit666/orbit/master/qrencode.sh)
        ;;
    4)
        echo "退出脚本"
        exit 0
        ;;
esac
