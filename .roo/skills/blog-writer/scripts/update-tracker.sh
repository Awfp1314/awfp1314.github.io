#!/bin/bash

# 更新转化跟踪文件的脚本

TRACKER_FILE=".kiro/skills/blog-writer/conversion-tracker.json"

# 显示使用方法
show_usage() {
    echo "用法: $0 <action> [参数]"
    echo ""
    echo "Actions:"
    echo "  add-converted <note_path> <blog_path>  - 标记笔记已转化"
    echo "  add-pending <note_path> <priority>     - 添加待转化笔记"
    echo "  add-skipped <note_path> <reason>       - 标记笔记跳过"
    echo "  list-converted                         - 列出已转化笔记"
    echo "  list-pending                           - 列出待转化笔记"
    echo "  list-skipped                           - 列出跳过的笔记"
    echo "  status                                 - 显示转化状态"
    echo ""
    echo "示例:"
    echo "  $0 add-converted '知识库/02_Notes/线性注意力.md' 'src/blog/2026/3/线性注意力.mdx'"
    echo "  $0 add-pending '知识库/02_Notes/新笔记.md' 'high'"
    echo "  $0 list-pending"
}

# 检查 jq 是否安装
if ! command -v jq &> /dev/null; then
    echo "❌ 需要安装 jq 工具"
    echo "   macOS: brew install jq"
    echo "   Ubuntu: sudo apt-get install jq"
    echo "   Windows: 使用 Git Bash 或 WSL"
    exit 1
fi

# 检查跟踪文件是否存在
if [ ! -f "$TRACKER_FILE" ]; then
    echo "❌ 跟踪文件不存在: $TRACKER_FILE"
    exit 1
fi

ACTION="$1"

case "$ACTION" in
    add-converted)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ 缺少参数"
            show_usage
            exit 1
        fi
        
        NOTE_PATH="$2"
        BLOG_PATH="$3"
        CURRENT_DATE=$(date +%Y-%m-%d)
        
        # 添加到已转化列表
        jq --arg note "$NOTE_PATH" \
           --arg blog "$BLOG_PATH" \
           --arg date "$CURRENT_DATE" \
           '.converted += [{
               "notePath": $note,
               "blogPath": $blog,
               "convertedDate": $date,
               "status": "published"
           }]' "$TRACKER_FILE" > "${TRACKER_FILE}.tmp"
        
        mv "${TRACKER_FILE}.tmp" "$TRACKER_FILE"
        echo "✅ 已添加到已转化列表: $NOTE_PATH"
        ;;
        
    add-pending)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ 缺少参数"
            show_usage
            exit 1
        fi
        
        NOTE_PATH="$2"
        PRIORITY="$3"
        REASON="${4:-待转化}"
        
        # 添加到待转化列表
        jq --arg note "$NOTE_PATH" \
           --arg priority "$PRIORITY" \
           --arg reason "$REASON" \
           '.pending += [{
               "notePath": $note,
               "priority": $priority,
               "reason": $reason
           }]' "$TRACKER_FILE" > "${TRACKER_FILE}.tmp"
        
        mv "${TRACKER_FILE}.tmp" "$TRACKER_FILE"
        echo "✅ 已添加到待转化列表: $NOTE_PATH (优先级: $PRIORITY)"
        ;;
        
    add-skipped)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ 缺少参数"
            show_usage
            exit 1
        fi
        
        NOTE_PATH="$2"
        REASON="$3"
        
        # 添加到跳过列表
        jq --arg note "$NOTE_PATH" \
           --arg reason "$REASON" \
           '.skipped += [{
               "notePath": $note,
               "reason": $reason
           }]' "$TRACKER_FILE" > "${TRACKER_FILE}.tmp"
        
        mv "${TRACKER_FILE}.tmp" "$TRACKER_FILE"
        echo "✅ 已添加到跳过列表: $NOTE_PATH"
        ;;
        
    list-converted)
        echo "📝 已转化的笔记:"
        echo ""
        jq -r '.converted[] | "  ✅ \(.notePath)\n     → \(.blogPath)\n     日期: \(.convertedDate)\n"' "$TRACKER_FILE"
        ;;
        
    list-pending)
        echo "⏳ 待转化的笔记:"
        echo ""
        jq -r '.pending[] | "  📌 \(.notePath)\n     优先级: \(.priority)\n     原因: \(.reason)\n"' "$TRACKER_FILE"
        ;;
        
    list-skipped)
        echo "⏭️  跳过的笔记:"
        echo ""
        jq -r '.skipped[] | "  ⏭️  \(.notePath)\n     原因: \(.reason)\n"' "$TRACKER_FILE"
        ;;
        
    status)
        echo "📊 转化状态统计"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        
        CONVERTED_COUNT=$(jq '.converted | length' "$TRACKER_FILE")
        PENDING_COUNT=$(jq '.pending | length' "$TRACKER_FILE")
        SKIPPED_COUNT=$(jq '.skipped | length' "$TRACKER_FILE")
        TOTAL=$((CONVERTED_COUNT + PENDING_COUNT + SKIPPED_COUNT))
        
        echo "✅ 已转化: $CONVERTED_COUNT 篇"
        echo "⏳ 待转化: $PENDING_COUNT 篇"
        echo "⏭️  已跳过: $SKIPPED_COUNT 篇"
        echo "📊 总计: $TOTAL 篇"
        echo ""
        
        if [ $PENDING_COUNT -gt 0 ]; then
            echo "下一篇建议转化:"
            jq -r '.pending[0] | "  📌 \(.notePath)\n     优先级: \(.priority)\n     原因: \(.reason)"' "$TRACKER_FILE"
        fi
        ;;
        
    *)
        echo "❌ 未知操作: $ACTION"
        show_usage
        exit 1
        ;;
esac
