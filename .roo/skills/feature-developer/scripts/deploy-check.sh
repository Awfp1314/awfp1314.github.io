#!/bin/bash

# 部署前检查脚本

echo "🚀 部署前检查..."

# 1. 检查 Git 状态
echo "1️⃣ 检查 Git 状态..."
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  有未提交的修改"
    git status --short
else
    echo "✅ 工作区干净"
fi

# 2. 检查当前分支
echo "2️⃣ 检查当前分支..."
BRANCH=$(git branch --show-current)
echo "   当前分支: $BRANCH"

# 3. 检查是否有未推送的提交
echo "3️⃣ 检查未推送的提交..."
UNPUSHED=$(git log origin/$BRANCH..$BRANCH --oneline)
if [ -n "$UNPUSHED" ]; then
    echo "⚠️  有未推送的提交:"
    echo "$UNPUSHED"
else
    echo "✅ 所有提交已推送"
fi

# 4. 运行构建测试
echo "4️⃣ 运行构建测试..."
npm run build > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ 构建成功"
else
    echo "❌ 构建失败，请先修复构建错误"
    exit 1
fi

echo ""
echo "✅ 部署前检查完成！"
