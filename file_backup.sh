#!/bin/bash
# ~/scripts/file_backup.sh
# 文件备份脚本

# 配置备份参数
SOURCE_DIR=~/Desktop          # 要备份的目录（桌面）
BACKUP_DIR=~/backup           # 备份存储目录
BACKUP_NAME=desktop_backup_$(date +%Y%m%d).tar.gz
RETENTION_DAYS=7              # 保留7天备份

# 创建备份目录（若不存在）
mkdir -p $BACKUP_DIR

# 开始备份（压缩为tar.gz格式）
echo "[$(date)] 开始备份 $SOURCE_DIR 到 $BACKUP_DIR/$BACKUP_NAME"
tar -zcf $BACKUP_DIR/$BACKUP_NAME $SOURCE_DIR

# 清理过期备份
echo "[$(date)] 清理 $RETENTION_DAYS 天前的备份..."
find $BACKUP_DIR -name "desktop_backup_*.tar.gz" -mtime +$RETENTION_DAYS -delete

# 备份完成提示
echo "[$(date)] 备份完成！当前备份文件：$BACKUP_DIR/$BACKUP_NAME"

