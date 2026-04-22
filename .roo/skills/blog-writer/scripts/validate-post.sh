#!/bin/bash

# 验证博客文章的脚本

if [ -z "$1" ]; then
    echo "用法: $0 <文章路径>"
    echo "示例: $0 src/blog/2026/3/线性注意力.mdx"
    exit 1
fi

POST_FILE="$1"

echo "📝 验证博客文章: $POST_FILE"
echo ""

# 检查文件是否存在
if [ ! -f "$POST_FILE" ]; then
    echo "❌ 文件不存在: $POST_FILE"
    exit 1
fi

ERROR_COUNT=0

# 1. 检查 frontmatter 必需字段
echo "1️⃣ 检查 frontmatter..."

if ! grep -q "^title:" "$POST_FILE"; then
    echo "   ❌ 缺少 title 字段"
    ((ERROR_COUNT++))
else
    echo "   ✅ title 字段存在"
fi

if ! grep -q "^description:" "$POST_FILE"; then
    echo "   ❌ 缺少 description 字段"
    ((ERROR_COUNT++))
else
    echo "   ✅ description 字段存在"
fi

if ! grep -q "^author:" "$POST_FILE"; then
    echo "   ❌ 缺少 author 字段"
    ((ERROR_COUNT++))
else
    echo "   ✅ author 字段存在"
fi

if ! grep -q "^pubDate:" "$POST_FILE"; then
    echo "   ❌ 缺少 pubDate 字段"
    ((ERROR_COUNT++))
else
    # 检查 pubDate 格式
    if grep -q 'pubDate: "' "$POST_FILE"; then
        echo "   ✅ pubDate 格式正确"
    else
        echo "   ⚠️  pubDate 应该使用引号包裹"
        ((ERROR_COUNT++))
    fi
fi

if ! grep -q "^tags:" "$POST_FILE"; then
    echo "   ❌ 缺少 tags 字段"
    ((ERROR_COUNT++))
else
    echo "   ✅ tags 字段存在"
fi

# 2. 检查内容质量
echo ""
echo "2️⃣ 检查内容质量..."

# 检查文章长度
CONTENT_LINES=$(grep -v "^---" "$POST_FILE" | grep -v "^$" | wc -l)
if [ "$CONTENT_LINES" -lt 20 ]; then
    echo "   ⚠️  文章内容较少 ($CONTENT_LINES 行)"
else
    echo "   ✅ 文章内容充实 ($CONTENT_LINES 行)"
fi

# 检查是否有标题
if grep -q "^# " "$POST_FILE"; then
    echo "   ✅ 包含一级标题"
else
    echo "   ⚠️  建议添加一级标题"
fi

# 检查是否有代码块
if grep -q '```' "$POST_FILE"; then
    echo "   ✅ 包含代码示例"
fi

# 3. 检查图片引用
echo ""
echo "3️⃣ 检查图片引用..."

IMAGE_REFS=$(grep -o '!\[\[.*\]\]' "$POST_FILE" | wc -l)
if [ "$IMAGE_REFS" -gt 0 ]; then
    echo "   ⚠️  发现 $IMAGE_REFS 个 Obsidian 格式的图片引用"
    echo "   建议转换为标准 Markdown 格式: ![alt](/blog-images/...)"
    ((ERROR_COUNT++))
else
    echo "   ✅ 图片引用格式正确"
fi

# 4. 检查链接
echo ""
echo "4️⃣ 检查链接..."

# 检查 Obsidian 双链
WIKI_LINKS=$(grep -o '\[\[.*\]\]' "$POST_FILE" | wc -l)
if [ "$WIKI_LINKS" -gt 0 ]; then
    echo "   ⚠️  发现 $WIKI_LINKS 个 Obsidian 双链"
    echo "   建议转换为标准 Markdown 链接: [text](/path)"
    ((ERROR_COUNT++))
else
    echo "   ✅ 链接格式正确"
fi

# 5. 总结
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $ERROR_COUNT -eq 0 ]; then
    echo "✅ 验证通过！文章可以发布"
    exit 0
else
    echo "❌ 发现 $ERROR_COUNT 个问题，请修复后再发布"
    exit 1
fi
