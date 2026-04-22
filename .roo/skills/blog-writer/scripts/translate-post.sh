#!/bin/bash

# 翻译博客文章的脚本
# 注意：这个脚本只是一个占位符，实际翻译由 AI 完成

if [ -z "$1" ]; then
    echo "用法: $0 <中文文章路径>"
    echo "示例: $0 src/blog/2026/3/线性注意力.mdx"
    exit 1
fi

ZH_FILE="$1"

if [ ! -f "$ZH_FILE" ]; then
    echo "❌ 文件不存在: $ZH_FILE"
    exit 1
fi

echo "🌐 准备翻译文章: $ZH_FILE"
echo ""

# 提取文件名和目录信息
FILENAME=$(basename "$ZH_FILE")
DIRNAME=$(dirname "$ZH_FILE")

# 生成英文文件名（保持相同目录结构）
# 例如：src/blog/2026/3/文章.mdx -> src/blog/2026/3/Article.mdx
EN_FILENAME="${FILENAME%.*}-en.${FILENAME##*.}"
EN_FILE="$DIRNAME/$EN_FILENAME"

echo "📝 中文文章: $ZH_FILE"
echo "📝 英文文章: $EN_FILE"
echo ""

# 检查英文文件是否已存在
if [ -f "$EN_FILE" ]; then
    echo "⚠️  英文文章已存在: $EN_FILE"
    echo "是否需要重新翻译？"
    exit 0
fi

echo "✅ 准备就绪，等待 AI 翻译..."
echo ""
echo "AI 将会："
echo "1. 读取中文文章内容"
echo "2. 翻译标题、描述和正文"
echo "3. 保持代码块和技术术语不变"
echo "4. 创建英文文章文件: $EN_FILE"
echo "5. 更新 frontmatter 的 lang 字段为 'en'"
echo "6. 保持相同的 pubDate"
