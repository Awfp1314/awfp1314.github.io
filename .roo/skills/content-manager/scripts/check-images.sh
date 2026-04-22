#!/bin/bash

# 检查图片使用情况的脚本

echo "📸 检查博客图片..."

IMAGE_DIR="public/blog-images"
BLOG_DIR="src/blog"

# 统计图片数量
echo "1️⃣ 统计图片..."
TOTAL_IMAGES=$(find "$IMAGE_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) | wc -l)
echo "   总图片数：$TOTAL_IMAGES"

# 按文件夹统计
echo ""
echo "2️⃣ 按文件夹统计..."
for dir in "$IMAGE_DIR"/*; do
    if [ -d "$dir" ]; then
        folder_name=$(basename "$dir")
        count=$(find "$dir" -type f | wc -l)
        echo "   $folder_name: $count 张"
    fi
done

# 检查大文件
echo ""
echo "3️⃣ 检查大文件 (> 500KB)..."
find "$IMAGE_DIR" -type f -size +500k -exec ls -lh {} \; | awk '{print "   " $9 " (" $5 ")"}'

# 检查图片引用（简单检查）
echo ""
echo "4️⃣ 检查图片引用..."
USED_COUNT=0
find "$IMAGE_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) | while read -r img; do
    img_name=$(basename "$img")
    if grep -r "$img_name" "$BLOG_DIR" > /dev/null 2>&1; then
        ((USED_COUNT++))
    fi
done

echo ""
echo "✅ 图片检查完成！"
