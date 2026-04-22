# 转化跟踪系统使用指南

## 概述

转化跟踪系统用于记录知识库笔记的转化状态，避免重复转化，并帮助规划转化优先级。

## 文件结构

```json
{
  "converted": [], // 已转化的笔记
  "pending": [], // 待转化的笔记
  "skipped": [] // 跳过的笔记
}
```

## 字段说明

### converted（已转化）

记录已经转化为博客的笔记：

```json
{
  "notePath": "知识库/02_Notes/MCP （模型上下文协议）.md",
  "blogPath": "src/blog/2026/3/MCP模型上下文协议.mdx",
  "convertedDate": "2026-03-15",
  "status": "published"
}
```

- **notePath**: 原笔记路径
- **blogPath**: 转化后的博客文章路径
- **convertedDate**: 转化日期
- **status**: 状态（published/draft）

### pending（待转化）

记录计划转化的笔记：

```json
{
  "notePath": "知识库/02_Notes/线性注意力.md",
  "priority": "high",
  "reason": "Transformer 相关主题，可以自然衔接"
}
```

- **notePath**: 笔记路径
- **priority**: 优先级（high/medium/low）
- **reason**: 转化原因或说明

### skipped（跳过）

记录不适合转化的笔记：

```json
{
  "notePath": "知识库/02_Notes/UeToolkit 新项目架构规划.md",
  "reason": "涉及商业机密"
}
```

- **notePath**: 笔记路径
- **reason**: 跳过原因

## 使用场景

### 场景 1：开始转化前

查看转化状态，了解哪些笔记已转化，哪些待转化：

```bash
# 查看整体状态
bash .kiro/skills/blog-writer/scripts/update-tracker.sh status

# 查看待转化列表
bash .kiro/skills/blog-writer/scripts/update-tracker.sh list-pending
```

输出示例：

```
📊 转化状态统计
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ 已转化: 4 篇
⏳ 待转化: 5 篇
⏭️  已跳过: 2 篇
📊 总计: 11 篇

下一篇建议转化:
  📌 知识库/02_Notes/线性注意力.md
     优先级: high
     原因: Transformer 相关主题，可以自然衔接
```

### 场景 2：转化完成后

将笔记标记为已转化：

```bash
bash .kiro/skills/blog-writer/scripts/update-tracker.sh add-converted \
  "知识库/02_Notes/线性注意力.md" \
  "src/blog/2026/3/线性注意力.mdx"
```

### 场景 3：发现新笔记

将新笔记添加到待转化列表：

```bash
bash .kiro/skills/blog-writer/scripts/update-tracker.sh add-pending \
  "知识库/02_Notes/新笔记.md" \
  "high" \
  "重要的技术概念"
```

### 场景 4：决定跳过某篇笔记

将笔记标记为跳过：

```bash
bash .kiro/skills/blog-writer/scripts/update-tracker.sh add-skipped \
  "知识库/02_Notes/私密笔记.md" \
  "涉及商业机密"
```

## 优先级规则

### high（高优先级）

适用于：

- 与已发布文章相关的主题（可以自然衔接）
- 实用性强的工具类文章
- 用户明确要求转化的笔记
- 内容充实且有深度理解的笔记

示例：

- 线性注意力（Transformer 相关）
- Obsidian 知识库搭建（实用工具）

### medium（中优先级）

适用于：

- 系列文章的后续内容
- 有一定实用性但不紧急的笔记
- 内容较完整但需要补充的笔记

示例：

- Obsidian OneDrive 同步（Obsidian 系列）
- Vercel 部署（博客相关）

### low（低优先级）

适用于：

- 可能重复的内容
- 内容较简略的笔记
- 不太适合公开发布的笔记

示例：

- Rust 环境准备（已有博客文章）
- 简单的操作步骤笔记

## 跳过原因分类

### 商业机密

涉及公司项目、未公开技术等：

```
"涉及商业机密"
"包含公司项目细节"
"未公开的技术方案"
```

### 内容不足

笔记内容过于简略，不适合转化为博客：

```
"内容过于简略"
"缺少个人理解"
"只是简单的操作步骤"
```

### 重复内容

已有类似的博客文章：

```
"已有类似文章"
"内容重复"
```

### 不适合公开

个人笔记、草稿等：

```
"个人笔记，不适合公开"
"草稿阶段，内容不完整"
```

## AI 使用指南

### 转化前检查

AI 在开始转化前应该：

1. 读取 `conversion-tracker.json`
2. 检查目标笔记是否在 `converted` 列表中
3. 如果已转化，提醒用户并询问是否重新转化
4. 如果在 `skipped` 列表中，说明跳过原因并询问是否继续

### 转化后更新

AI 在转化完成后应该：

1. 使用 `update-tracker.sh add-converted` 更新跟踪文件
2. 如果笔记在 `pending` 列表中，从列表中移除
3. 告知用户跟踪文件已更新

**重要**：转化时的 pubDate 处理

- 使用原笔记的创建时间，不是转化当天的日期
- 使用 `get-file-date.sh` 脚本获取文件创建时间
- 如果无法获取创建时间，使用修改时间

```bash
# 获取笔记创建时间
bash .kiro/skills/blog-writer/scripts/get-file-date.sh "知识库/02_Notes/线性注意力.md"

# 输出：
# 创建时间: 2026-03-28
# 建议使用创建时间作为 pubDate: "2026-03-28"
```

### 建议下一篇

AI 可以根据 `pending` 列表建议下一篇转化：

```
根据转化跟踪，建议下一篇转化：
📌 线性注意力
   优先级: high
   原因: Transformer 相关主题，可以自然衔接

是否开始转化这篇笔记？
```

## 维护建议

### 定期检查

建议定期检查跟踪文件：

```bash
# 每周检查一次转化状态
bash .kiro/skills/blog-writer/scripts/update-tracker.sh status
```

### 更新优先级

根据实际情况调整优先级：

- 用户明确要求的笔记 → 提升为 high
- 已过时的内容 → 降低优先级或跳过
- 新增的重要笔记 → 添加到 pending 列表

### 清理跟踪文件

定期清理不需要的记录：

- 删除已删除的笔记记录
- 更新笔记路径（如果移动了文件）
- 合并重复的记录

## 示例工作流

### 完整的转化流程

```bash
# 1. 查看转化状态
bash .kiro/skills/blog-writer/scripts/update-tracker.sh status

# 2. 查看待转化列表
bash .kiro/skills/blog-writer/scripts/update-tracker.sh list-pending

# 3. AI 转化笔记（自动完成）

# 4. 标记为已转化
bash .kiro/skills/blog-writer/scripts/update-tracker.sh add-converted \
  "知识库/02_Notes/线性注意力.md" \
  "src/blog/2026/3/线性注意力.mdx"

# 5. 再次查看状态
bash .kiro/skills/blog-writer/scripts/update-tracker.sh status
```

## 常见问题

### Q: 如何批量添加待转化笔记？

A: 可以手动编辑 `conversion-tracker.json` 文件，或者使用脚本循环添加。

### Q: 如何修改已转化笔记的信息？

A: 直接编辑 `conversion-tracker.json` 文件，修改对应的记录。

### Q: 如何从 pending 移除笔记？

A: 可以将其添加到 skipped 列表，或者直接编辑 JSON 文件删除。

### Q: 跟踪文件丢失了怎么办？

A: 可以根据已发布的博客文章重新构建跟踪文件，或者从备份恢复。

## 最佳实践

1. **及时更新** - 每次转化完成后立即更新跟踪文件
2. **清晰原因** - 添加 pending 或 skipped 时写清楚原因
3. **合理优先级** - 根据实际情况设置优先级
4. **定期检查** - 定期查看转化状态，规划下一步
5. **备份文件** - 定期备份跟踪文件，防止丢失
