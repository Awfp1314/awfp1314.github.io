#!/bin/bash

# 检查响应式样式的脚本

echo "📱 检查响应式样式..."

# 检查是否使用了响应式断点
echo "1️⃣ 检查响应式断点使用..."
grep -r "sm:\|md:\|lg:\|xl:\|2xl:" src/ --include="*.astro" --include="*.tsx" --include="*.jsx" | wc -l
echo "   找到响应式类名使用"

# 检查是否有固定宽度
echo "2️⃣ 检查固定宽度..."
grep -r "w-\[.*px\]" src/ --include="*.astro" --include="*.tsx" --include="*.jsx" || echo "   ✅ 没有使用固定像素宽度"

# 检查移动端隐藏/显示
echo "3️⃣ 检查移动端显示控制..."
grep -r "hidden.*md:block\|block.*md:hidden" src/ --include="*.astro" --include="*.tsx" --include="*.jsx" | wc -l
echo "   找到移动端显示控制"

echo ""
echo "✅ 响应式检查完成！"
