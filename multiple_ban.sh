#!/bin/bash

# 服务器配置数组，格式: [索引]="IP地址 端口号 RCON密码"
declare -A SERVER_CONFIGS=(
    # 示例配置 - 请根据实际情况修改
    [1]="<IP> <PORT> <RCON_PASSWORD>"
#    [2]="127.0.0.1 40002 123456"
)

# 检查参数数量
if [ "$#" -lt 2 ]; then
    echo "用法: $0 <服务器列表，如1,3,5> <玩家ID/名称> [封禁原因]"
    echo "示例: $0 1,2,3 76561198787872653 \"使用外挂\""
    echo "示例: $0 1-5 \"Bad Player\" \"骚扰行为\""
    echo "可用服务器索引: ${!SERVER_CONFIGS[@]}"
    exit 1
fi

# 获取参数
SERVER_RANGE="$1"
PLAYER="$2"
REASON="${3:-违反服务器规则}"

# 解析服务器列表
declare -a SERVERS
if [[ "$SERVER_RANGE" =~ ^[0-9,-]+$ ]]; then
    # 处理1,3,5格式
    IFS=',' read -r -a PARTS <<< "$SERVER_RANGE"
    for part in "${PARTS[@]}"; do
        if [[ "$part" =~ ^[1-9]$ ]]; then
            # 检查索引是否存在配置
            if [[ -n "${SERVER_CONFIGS[$part]}" ]]; then
                SERVERS+=("$part")
            else
                echo "警告: 服务器 $part 没有配置，将被跳过"
            fi
        elif [[ "$part" =~ ^([1-9])-([1-9])$ ]]; then
            start=${BASH_REMATCH[1]}
            end=${BASH_REMATCH[2]}
            if (( start <= end )); then
                for ((i=start; i<=end; i++)); do
                    # 检查索引是否存在配置
                    if [[ -n "${SERVER_CONFIGS[$i]}" ]]; then
                        SERVERS+=("$i")
                    else
                        echo "警告: 服务器 $i 没有配置，将被跳过"
                    fi
                done
            fi
        fi
    done
else
    echo "错误：服务器列表格式无效，请使用如1,3,5或1-3的格式"
    exit 1
fi

# 去重排序
IFS=$'\n' unique_servers=($(sort -u <<< "${SERVERS[*]}"))
unset IFS

if [ ${#unique_servers[@]} -eq 0 ]; then
    echo "错误: 没有有效的服务器配置"
    exit 1
fi

echo "准备在以下服务器封禁玩家: ${unique_servers[*]}"
echo "玩家: $PLAYER"
echo "原因: $REASON"
echo

# 遍历服务器执行封禁
for index in "${unique_servers[@]}"; do
    # 从配置中获取IP、端口和RCON密码
    read -r ip port rcon_password <<< "${SERVER_CONFIGS[$index]}"
    
    echo -e "\n正在服务器 #$index ($ip:$port) 执行封禁..."
    #echo "执行命令: ./ban_player.sh \"$ip\" \"$port\" \"$rcon_password\" \"$PLAYER\" \"$REASON\""
    
    SERVER_IP="${ip}:${port}"
    RCON_PASSWORD=${rcon_password}
    RCON_COMMAND="banid \"$PLAYER\" -1 \"$REASON\""
    # 实际执行封禁命令
    rcon -a "$SERVER_IP" -p "$RCON_PASSWORD" "$RCON_COMMAND" 
    if [ $? -eq 0 ]; then
        echo "✅ 成功永久封禁玩家: $PLAYER"
        echo "🖥️o 服务器: #${SERVER_NUM} (${SERVER_IP})"
        echo "📝 封禁原因: $REASON"
    else
        echo "❌ 封禁玩家失败，请检查:"
        echo "1. RCON密码是否正确"
        echo "2. 服务器序号是否正确"
        echo "3. 玩家标识是否存在"
        echo "4. 您是否有封禁权限"
fi
    # 添加延迟避免频繁操作
    if (( ${#unique_servers[@]} > 1 )); then
        sleep 0.3
    fi
done

echo -e "\n封禁操作已完成"
