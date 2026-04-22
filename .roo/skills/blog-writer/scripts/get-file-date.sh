#!/bin/bash

# 获取文件创建时间的脚本

if [ -z "$1" ]; then
    echo "用法: $0 <文件路径>"
    echo "示例: $0 知识库/02_Notes/线性注意力.md"
    exit 1
fi

FILE_PATH="$1"

if [ ! -f "$FILE_PATH" ]; then
    echo "❌ 文件不存在: $FILE_PATH"
    exit 1
fi

echo "📅 获取文件时间信息: $FILE_PATH"
echo ""

# 根据操作系统获取文件创建时间
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    BIRTH_TIME=$(stat -f "%SB" -t "%Y-%m-%d" "$FILE_PATH")
    MODIFY_TIME=$(stat -f "%Sm" -t "%Y-%m-%d" "$FILE_PATH")
    
    echo "创建时间: $BIRTH_TIME"
    echo "修改时间: $MODIFY_TIME"
    echo ""
    echo "建议使用创建时间作为 pubDate: \"$BIRTH_TIME\""
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    # 注意：Linux 的 stat 可能不支持创建时间，使用修改时间
    MODIFY_TIME=$(stat -c "%y" "$FILE_PATH" | cut -d' ' -f1)
    
    echo "修改时间: $MODIFY_TIME"
    echo ""
    echo "⚠️  Linux 系统可能无法获取创建时间"
    echo "建议使用修改时间作为 pubDate: \"$MODIFY_TIME\""
    
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    # Windows (Git Bash / Cygwin)
    # Windows 使用 PowerShell 获取创建时间
    BIRTH_TIME=$(powershell.exe -Command "(Get-Item '$FILE_PATH').CreationTime.ToString('yyyy-MM-dd')" 2>/dev/null)
    MODIFY_TIME=$(powershell.exe -Command "(Get-Item '$FILE_PATH').LastWriteTime.ToString('yyyy-MM-dd')" 2>/dev/null)
    
    if [ -n "$BIRTH_TIME" ]; then
        echo "创建时间: $BIRTH_TIME"
        echo "修改时间: $MODIFY_TIME"
        echo ""
        echo "建议使用创建时间作为 pubDate: \"$BIRTH_TIME\""
    else
        # 如果 PowerShell 失败，使用 stat
        MODIFY_TIME=$(stat -c "%y" "$FILE_PATH" 2>/dev/null | cut -d' ' -f1)
        echo "修改时间: $MODIFY_TIME"
        echo ""
        echo "建议使用修改时间作为 pubDate: \"$MODIFY_TIME\""
    fi
else
    echo "❌ 不支持的操作系统: $OSTYPE"
    exit 1
fi
