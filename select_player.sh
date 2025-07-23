#!/bin/bash

# 声明服务器配置数组
declare -A SERVER_CONFIGS=(
    [1]="<IP> <PORT> <RCON_PASSWORD>"
#    [2]="127.0.0.1 40002 123456"

)

# 检查是否提供了参数
if [ -z "$1" ]; then
    echo "请提供一个服务器下标"
    exit 1
fi

# 获取传入的服务器下标
SERVER_INDEX=$1

# 检查指定的下标是否在服务器配置中
if [ -n "${SERVER_CONFIGS[$SERVER_INDEX]}" ]; then
    # 从配置中提取IP、端口和密码
    SERVER_INFO=(${SERVER_CONFIGS[$SERVER_INDEX]})
    IP=${SERVER_INFO[0]}
    PORT=${SERVER_INFO[1]}
    PASSWORD=${SERVER_INFO[2]}

    # 使用rcon查询该服务器的玩家信息
    players_info=$(rcon -a "$IP:$PORT" -p "$PASSWORD" listplayers)
    players_info=$(echo "$players_info" | tr '|' '\n')
    players_info=$(echo "$players_info" | sed '1,/^===============================================================================/d')
    # 处理输出数据，提取有效玩家信息
filtered_players=$(echo "$players_info" | awk '
  {
    line = $0
    gsub(/\t/, "", line)           # 删除整行所有制表符
    sub(/^[ \t]+/, "", line)    # 去除行首空格和制表符
  }
  NR % 5 == 2 { name = line }
  NR % 5 == 3 { steam = line }
  NR % 5 == 0 {
    score = line
    if (steam ~ /^SteamNWI:/)
      print name, steam, score
  }
')

line_count=$(echo "$filtered_players" | wc -l)
echo "共有 $line_count 名玩家在服务器中"

echo "$filtered_players"
    # 输出筛选后的玩家信息
else
    # 如果指定的下标无效
    echo "无效的服务器下标: $SERVER_INDEX"
    exit 1
fi
