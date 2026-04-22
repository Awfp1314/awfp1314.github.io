#!/bin/bash

# 检查文章元数据的脚本

echo "📝 检查文章元数据..."

BLOG_DIR="src/blog"
TOTAL_FILES=0
ERROR_FILES=0
MISSING_PAIRS=0

# 存储所有文件信息
declare -A zh_files
declare -A en_files

echo ""
echo "=== 第一步：检查必需字段 ==="

# 查找所有 MDX 文件
while IFS= read -r file; do
    ((TOTAL_FILES++))
    FILE_ERROR=0
    
    echo ""
    echo "检查: $file"
    
    # 检查必需字段
    if ! grep -q "^title:" "$file"; then
        echo "  ❌ 缺少 title 字段"
        ((FILE_ERROR++))
    fi
    
    if ! grep -q "^description:" "$file"; then
        echo "  ❌ 缺少 description 字段"
        ((FILE_ERROR++))
    fi
    
    if ! grep -q "^author:" "$file"; then
        echo "  ❌ 缺少 author 字段"
        ((FILE_ERROR++))
    fi
    
    if ! grep -q "^pubDate:" "$file"; then
        echo "  ❌ 缺少 pubDate 字段"
        ((FILE_ERROR++))
    else
        # 检查 pubDate 格式
        if ! grep -q 'pubDate: "' "$file"; then
            echo "  ⚠️  pubDate 应该使用引号包裹"
        fi
    fi
    
    if ! grep -q "^tags:" "$file"; then
        echo "  ❌ 缺少 tags 字段"
        ((FILE_ERROR++))
    fi
    
    # 检查 lang 字段
    if ! grep -q "^lang:" "$file"; then
        echo "  ⚠️  缺少 lang 字段（将默认为 'zh'）"
        # 默认为中文
        filename=$(basename "$file" .mdx)
        year_month=$(echo "$file" | grep -oP '\d{4}/\d+')
        zh_files["$year_month/$filename"]="$file"
    else
        # 提取 lang 值 - 使用 awk 更可靠
        lang_value=$(awk -F': *' '/^lang:/ {gsub(/[" \t\r\n]/, "", $2); print $2}' "$file")
        
        if [[ "$lang_value" != "zh" && "$lang_value" != "en" ]]; then
            echo "  ❌ lang 字段值无效（应为 'zh' 或 'en'）"
            ((FILE_ERROR++))
        else
            # 提取文件路径信息用于配对检查
            filename=$(basename "$file" .mdx)
            year_month=$(echo "$file" | grep -oP '\d{4}/\d+')
            
            if [[ "$lang_value" == "zh" ]]; then
                zh_files["$year_month/$filename"]="$file"
            else
                en_files["$year_month/$filename"]="$file"
            fi
        fi
    fi
    
    if [ $FILE_ERROR -eq 0 ]; then
        echo "  ✅ 元数据完整"
    else
        ((ERROR_FILES++))
    fi
done < <(find "$BLOG_DIR" -name "*.mdx")

echo ""
echo "=== 第二步：检查多语言配对 ==="
echo ""

# 检查中文文章是否有对应的英文版本
for key in "${!zh_files[@]}"; do
    zh_file="${zh_files[$key]}"
    
    # 尝试查找对应的英文版本
    found_pair=false
    for en_key in "${!en_files[@]}"; do
        # 检查是否是同一篇文章（年月相同）
        if [[ "${key%/*}" == "${en_key%/*}" ]]; then
            # 检查 pubDate 是否一致
            zh_date=$(awk -F': *' '/^pubDate:/ {gsub(/[" \t\r\n]/, "", $2); print $2}' "$zh_file")
            en_date=$(awk -F': *' '/^pubDate:/ {gsub(/[" \t\r\n]/, "", $2); print $2}' "${en_files[$en_key]}")
            
            if [[ "$zh_date" == "$en_date" ]]; then
                echo "✅ $(basename "$zh_file" .mdx)"
                echo "   └─ 英文版本: $(basename "${en_files[$en_key]}" .mdx)"
                found_pair=true
                break
            fi
        fi
    done
    
    if [ "$found_pair" = false ]; then
        echo "⚠️  $(basename "$zh_file" .mdx)"
        echo "   └─ 缺少英文版本"
        ((MISSING_PAIRS++))
    fi
done

# 检查英文文章是否有对应的中文版本
for key in "${!en_files[@]}"; do
    en_file="${en_files[$key]}"
    
    # 尝试查找对应的中文版本
    found_pair=false
    for zh_key in "${!zh_files[@]}"; do
        if [[ "${key%/*}" == "${zh_key%/*}" ]]; then
            zh_date=$(awk -F': *' '/^pubDate:/ {gsub(/[" \t\r\n]/, "", $2); print $2}' "${zh_files[$zh_key]}")
            en_date=$(awk -F': *' '/^pubDate:/ {gsub(/[" \t\r\n]/, "", $2); print $2}' "$en_file")
            
            if [[ "$zh_date" == "$en_date" ]]; then
                found_pair=true
                break
            fi
        fi
    done
    
    if [ "$found_pair" = false ]; then
        echo "⚠️  $(basename "$en_file" .mdx)"
        echo "   └─ 缺少中文版本"
        ((MISSING_PAIRS++))
    fi
done

echo ""
echo "=== 检查总结 ==="
echo "📊 总文件数: $TOTAL_FILES"
echo "❌ 元数据错误: $ERROR_FILES"
echo "⚠️  缺少语言配对: $MISSING_PAIRS"

if [ $ERROR_FILES -eq 0 ] && [ $MISSING_PAIRS -eq 0 ]; then
    echo ""
    echo "✅ 所有检查通过！"
    exit 0
else
    echo ""
    echo "⚠️  发现问题，请修复后重新检查"
    exit 1
fi
