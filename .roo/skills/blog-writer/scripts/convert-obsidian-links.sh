#!/bin/bash

# 转换 Obsidian 格式到标准 Markdown 格式的脚本

if [ -z "$1" ]; then
    echo "用法: $0 <文章路径>"
    echo "示例: $0 src/blog/2026/3/线性注意力.mdx"
    exit 1
fi

POST_FILE="$1"

echo "🔄 转换 Obsidian 格式: $POST_FILE"
echo ""

if [ ! -f "$POST_FILE" ]; then
    echo "❌ 文件不存在: $POST_FILE"
    exit 1
fi

# 备份原文件
BACKUP_FILE="${POST_FILE}.backup"
cp "$POST_FILE" "$BACKUP_FILE"
echo "✅ 已备份原文件到: $BACKUP_FILE"
echo ""

CHANGES=0

# 1. 转换图片引用 ![[image.png]] -> ![](/blog-images/folder/image.png)
echo "1️⃣ 转换图片引用..."
IMAGE_REFS=$(grep -o '!\[\[.*\]\]' "$POST_FILE" | wc -l)
if [ "$IMAGE_REFS" -gt 0 ]; then
    echo "   发现 $IMAGE_REFS 个 Obsidian 格式的图片"
    echo "   ⚠️  需要手动指定图片路径"
    echo "   格式: ![[image.png]] -> ![alt](/blog-images/folder/image.png)"
    ((CHANGES++))
else
    echo "   ✅ 没有需要转换的图片引用"
fi

# 2. 转换双链 [[笔记名]] -> [笔记名](/path)
echo ""
echo "2️⃣ 转换双链..."
WIKI_LINKS=$(grep -o '\[\[.*\]\]' "$POST_FILE" | grep -v '!\[\[' | wc -l)
if [ "$WIKI_LINKS" -gt 0 ]; then
    echo "   发现 $WIKI_LINKS 个 Obsidian 双链"
    
    # 列出所有双链
    echo "   双链列表:"
    grep -o '\[\[.*\]\]' "$POST_FILE" | grep -v '!\[\[' | while read -r link; do
        echo "     - $link"
    done
    
    echo ""
    echo "   ⚠️  需要手动转换为标准链接"
    echo "   格式: [[笔记名]] -> [笔记名](/相对路径)"
    ((CHANGES++))
else
    echo "   ✅ 没有需要转换的双链"
fi

# 3. 检查其他 Obsidian 特性
echo ""
echo "3️⃣ 检查其他 Obsidian 特性..."

# 检查标签 #tag
if grep -q '#[a-zA-Z]' "$POST_FILE"; then
    echo "   ⚠️  发现 Obsidian 标签 (#tag)"
    echo "   建议移除或转换为 frontmatter tags"
    ((CHANGES++))
fi

# 检查高亮 ==text==
if grep -q '==.*==' "$POST_FILE"; then
    echo "   ⚠️  发现 Obsidian 高亮 (==text==)"
    echo "   建议转换为 <mark>text</mark> 或加粗"
    ((CHANGES++))
fi

# 检查注释 %%comment%%
if grep -q '%%.*%%' "$POST_FILE"; then
    echo "   ⚠️  发现 Obsidian 注释 (%%comment%%)"
    echo "   建议删除或转换为 HTML 注释"
    ((CHANGES++))
fi

# 4. 总结
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $CHANGES -eq 0 ]; then
    echo "✅ 没有需要转换的内容"
    rm "$BACKUP_FILE"
    echo "已删除备份文件"
else
    echo "⚠️  发现 $CHANGES 类需要转换的内容"
    echo ""
    echo "备份文件: $BACKUP_FILE"
    echo "请手动完成转换后删除备份文件"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
