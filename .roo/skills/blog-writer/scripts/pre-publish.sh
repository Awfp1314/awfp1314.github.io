#!/bin/bash

# 发布前检查脚本

if [ -z "$1" ]; then
    echo "用法: $0 <文章路径>"
    echo "示例: $0 src/blog/2026/3/线性注意力.mdx"
    exit 1
fi

POST_FILE="$1"

echo "🚀 发布前检查: $POST_FILE"
echo ""

# 1. 验证文章
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 1: 验证文章内容"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash "$(dirname "$0")/validate-post.sh" "$POST_FILE"
if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 文章验证失败，请先修复问题"
    exit 1
fi

# 2. 构建测试
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 2: 构建测试"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
npm run build > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ 构建成功"
else
    echo "❌ 构建失败，请检查错误信息"
    npm run build
    exit 1
fi

# 3. 检查 Git 状态
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 3: 检查 Git 状态"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 检查是否在 Git 仓库中
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "⚠️  不在 Git 仓库中"
else
    # 检查文件是否已暂存
    if git diff --cached --name-only | grep -q "$POST_FILE"; then
        echo "✅ 文章已暂存"
    else
        echo "⚠️  文章未暂存，建议运行: git add $POST_FILE"
    fi
    
    # 检查是否有未提交的修改
    if [ -n "$(git status --porcelain)" ]; then
        echo "⚠️  有未提交的修改"
        git status --short
    else
        echo "✅ 工作区干净"
    fi
fi

# 4. 生成文章信息
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 4: 文章信息"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 提取标题
TITLE=$(grep "^title:" "$POST_FILE" | sed 's/title: *"\(.*\)"/\1/')
echo "标题: $TITLE"

# 提取标签
TAGS=$(grep "^tags:" "$POST_FILE" | sed 's/tags: *//')
echo "标签: $TAGS"

# 提取发布日期
PUBDATE=$(grep "^pubDate:" "$POST_FILE" | sed 's/pubDate: *"\(.*\)"/\1/')
echo "发布日期: $PUBDATE"

# 统计字数
WORD_COUNT=$(grep -v "^---" "$POST_FILE" | wc -w)
echo "字数: 约 $WORD_COUNT 字"

# 5. 最终确认
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ 所有检查通过！"
echo ""
echo "建议的提交信息："
echo "git commit -m \"新增博客：$TITLE\""
echo ""
echo "准备好发布了吗？"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
