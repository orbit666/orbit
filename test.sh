#!/bin/bash

# 定义函数显示菜单选项并等待用户输入
function show_menu() {
    echo "请选择一项操作:"
    echo -e "\033[33m1.jerry脚本,自定义选项   2.yabs vps测试脚本   3.看看色图  4.退出\033[0m"

    while true; do
        read -p "请输入选项编号: " option

        if [[ "$option" =~ ^[1-4]$ ]]; then
            break
        else
            echo "选项无效，请重新输入。"
        fi
    done

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

    # 执行完选项后再次调用该函数
    show_menu
}

# 调用函数
show_menu
