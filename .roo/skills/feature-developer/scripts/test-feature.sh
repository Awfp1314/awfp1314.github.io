#!/bin/bash

# 测试功能的脚本

echo "🧪 开始功能测试..."

# 1. 构建测试
echo "1️⃣ 构建测试..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ 构建失败"
    exit 1
fi
echo "✅ 构建成功"

# 2. 检查输出目录
echo "2️⃣ 检查输出目录..."
if [ -d "dist" ]; then
    echo "✅ dist 目录存在"
    echo "📊 构建文件统计："
    echo "   HTML 文件: $(find dist -name "*.html" | wc -l)"
    echo "   CSS 文件: $(find dist -name "*.css" | wc -l)"
    echo "   JS 文件: $(find dist -name "*.js" | wc -l)"
else
    echo "❌ dist 目录不存在"
    exit 1
fi

# 3. 检查关键文件
echo "3️⃣ 检查关键文件..."
if [ -f "dist/index.html" ]; then
    echo "✅ 主页文件存在"
else
    echo "❌ 主页文件不存在"
    exit 1
fi

if [ -f "dist/blog/index.html" ]; then
    echo "✅ 博客页面存在"
else
    echo "❌ 博客页面不存在"
    exit 1
fi

echo ""
echo "🎉 所有测试通过！"
