#!/bin/bash

# 检查构建是否成功的脚本

echo "🔨 开始构建检查..."

# 运行构建
npm run build

# 检查构建结果
if [ $? -eq 0 ]; then
    echo "✅ 构建成功！"
    exit 0
else
    echo "❌ 构建失败，请检查错误信息"
    exit 1
fi
