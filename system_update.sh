#!/bin/bash
# ~/scripts/system_update.sh
# 系统自动更新脚本

# 定义日志文件
LOG_FILE=~/scripts/system_update.log
# 清空旧日志
> $LOG_FILE

# 日志函数（同时输出到屏幕和日志）
log() {
    echo "[$(date +%Y-%m-%d %H:%M:%S)] $1" | tee -a $LOG_FILE
}

# 开始更新
log "========== 开始系统更新 =========="
log "1. 更新软件源列表..."
sudo apt update >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    log "ERROR: 软件源更新失败！"
    exit 1
fi

log "2. 升级已安装软件包..."
sudo apt upgrade -y >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    log "ERROR: 软件包升级失败！"
    exit 1
fi

log "3. 清理无用包..."
sudo apt autoremove -y >> $LOG_FILE 2>&1

log "========== 系统更新完成 =========="


