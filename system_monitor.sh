#!/bin/bash
# ~/scripts/system_monitor.sh
# 系统资源监控脚本

# 定义日志文件路径
LOG_FILE=~/scripts/system_monitor.log
# 定义时间戳格式
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# 日志输出函数
log() {
    echo "[$TIMESTAMP] $1" >> $LOG_FILE
}

# 清空旧日志（可选：保留7天日志，这里简化为每日覆盖）
> $LOG_FILE

# 1. 获取CPU使用率（借助top命令）
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
# 2. 获取内存使用率（借助free命令）
MEM_USAGE=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
# 3. 获取根目录磁盘使用率
DISK_USAGE=$(df -h / | grep / | awk '{print $5}')

# 输出监控信息到日志
log "========== 系统资源监控报告 =========="
log "CPU 使用率: $CPU_USAGE%"
log "内存使用率: $MEM_USAGE"
log "根目录磁盘使用率: $DISK_USAGE"
log "======================================"


