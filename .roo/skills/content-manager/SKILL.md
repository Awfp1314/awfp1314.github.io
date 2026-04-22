---
name: content-manager
description: 博客内容管理技能，当用户提出检查文章、管理图片、优化内容等需求时激活
---

# 内容管理技能

这个技能用于管理博客的内容资源，包括文章元数据检查、图片管理、标签管理等。

## 激活条件

当用户提出以下需求时激活：

- "检查文章元数据"
- "管理博客图片"
- "优化图片"
- "检查死链"
- "生成内容报告"
- "整理标签"
- 或其他内容管理相关需求

**不激活的情况**：

- 功能开发（使用 feature-developer）
- 样式调整（使用 style-optimizer）
- 写博客文章（使用 blog-writer）

## 内容结构

```
src/blog/
├── 2026/
│   ├── 3/
│   │   ├── MCP模型上下文协议.mdx
│   │   ├── Transformer架构.mdx
│   │   └── ...
│   └── 4/
│       └── ...

public/blog-images/
├── openclaw/
│   └── *.png
├── uetoolkit/
│   └── *.png
└── ...
```

## 工作流程

### Step 1：内容扫描

1. **扫描文章目录**：
   - 使用 `listDirectory` 扫描 `src/blog/` 目录
   - 统计文章数量
   - 按年月分组

2. **扫描图片目录**：
   - 扫描 `public/blog-images/` 目录
   - 统计图片数量和大小
   - 按文件夹分组

3. **生成概览**：

   ```
   📊 内容概览

   文章统计：
   - 总数：7 篇
   - 2026年3月：5 篇
   - 2026年4月：2 篇

   图片统计：
   - 总数：57 张
   - openclaw：31 张
   - uetoolkit：26 张
   - 总大小：约 XX MB
   ```

### Step 2：元数据检查

1. **检查必需字段**：
   - title（标题）
   - description（描述）
   - author（作者）
   - pubDate（发布日期）
   - tags（标签）
   - lang（语言标识）

2. **检查格式规范**：
   - pubDate 是否为字符串格式
   - tags 是否为数组
   - lang 是否为 'zh' 或 'en'
   - 字段是否有引号

3. **检查多语言配对**：
   - 中文文章是否有对应的英文版本
   - 英文文章是否有对应的中文版本
   - 两个版本的 pubDate 是否一致
   - 两个版本的 tags 是否对应

4. **生成检查报告**：
   ```
   ✅ MCP模型上下文协议.mdx - 元数据完整
      ✅ 英文版本存在: MCP-Model-Context-Protocol.mdx
   ✅ Transformer架构.mdx - 元数据完整
      ⚠️  英文版本缺失
   ⚠️  某篇文章.mdx - 缺少 lang 字段
   ```

**参考脚本**：

- `scripts/check-metadata.sh` - 检查元数据
- `scripts/validate-frontmatter.js` - 验证 frontmatter

### Step 3：图片管理

1. **检查图片引用**：
   - 扫描文章中的图片引用
   - 检查图片文件是否存在
   - 识别未使用的图片

2. **图片优化建议**：
   - 检查图片大小（> 500KB 建议压缩）
   - 检查图片格式（建议使用 WebP）
   - 检查图片命名规范

3. **生成图片报告**：

   ```
   📸 图片报告

   使用中的图片：45 张
   未使用的图片：12 张

   需要优化的图片：
   - openclaw-20260411132621.png (1.2MB) - 建议压缩
   - uetoolkit-image-large.png (800KB) - 建议压缩
   ```

**参考脚本**：

- `scripts/check-images.sh` - 检查图片
- `scripts/optimize-images.sh` - 优化图片

### Step 4：标签管理

1. **收集所有标签**：
   - 扫描所有文章的 tags 字段
   - 统计标签使用频率
   - 识别相似标签

2. **标签规范化**：
   - 检查标签命名一致性
   - 建议合并相似标签
   - 建议标签分类

3. **生成标签报告**：

   ```
   🏷️ 标签报告

   常用标签：
   - AI (5 篇)
   - 深度学习 (3 篇)
   - LLM (2 篇)

   建议优化：
   - "人工智能" 和 "AI" 建议统一
   - "机器学习" 和 "ML" 建议统一
   ```

### Step 5：死链检查

1. **检查内部链接**：
   - 扫描文章中的内部链接
   - 验证链接目标是否存在
   - 识别失效链接

2. **检查外部链接**（可选）：
   - 扫描外部链接
   - 检查链接是否可访问

3. **生成链接报告**：

   ```
   🔗 链接检查

   内部链接：23 个
   - ✅ 有效：21 个
   - ❌ 失效：2 个

   失效链接：
   - /blog/old-post (在 MCP模型上下文协议.mdx 中)
   ```

### Step 6：生成报告

1. **综合报告**：
   - 内容统计
   - 元数据检查结果
   - 图片管理建议
   - 标签优化建议
   - 死链检查结果

2. **提供修复建议**：
   - 列出需要修复的问题
   - 提供修复方案
   - 询问是否需要自动修复

3. **执行修复**（如果用户同意）：
   - 修复元数据问题
   - 删除未使用的图片
   - 更新标签
   - 修复死链

## 常见管理场景

### 场景 1：检查文章元数据

```
你: 检查所有文章的元数据

AI 会：
1. 扫描所有文章
2. 检查必需字段
3. 检查格式规范
4. 生成检查报告
5. 提供修复建议
```

### 场景 2：优化图片

```
你: 优化博客图片

AI 会：
1. 扫描所有图片
2. 检查图片大小
3. 识别需要压缩的图片
4. 提供优化建议
5. 询问是否执行优化
```

### 场景 3：整理标签

```
你: 整理博客标签

AI 会：
1. 收集所有标签
2. 统计使用频率
3. 识别相似标签
4. 提供规范化建议
5. 询问是否批量更新
```

### 场景 4：清理未使用的图片

```
你: 清理未使用的图片

AI 会：
1. 扫描所有图片
2. 检查图片引用
3. 识别未使用的图片
4. 列出待删除列表
5. 询问确认后删除
```

## 元数据规范

### 必需字段

```yaml
---
title: "文章标题"
description: "文章描述"
author: HUTAO667
pubDate: "2026-03-15"
tags: ["标签1", "标签2", "标签3"]
---
```

### 字段说明

- **title**: 文章标题，必需，字符串
- **description**: 文章描述，必需，字符串
- **author**: 作者，必需，固定为 "HUTAO667"
- **pubDate**: 发布日期，必需，格式 "YYYY-MM-DD"
- **tags**: 标签数组，必需，至少1个标签

### 常见错误

```yaml
# ❌ 错误：pubDate 没有引号
pubDate: 2026-03-15

# ✅ 正确
pubDate: "2026-03-15"

# ❌ 错误：缺少 author
title: "标题"
pubDate: "2026-03-15"

# ✅ 正确
title: "标题"
author: HUTAO667
pubDate: "2026-03-15"
```

## 图片管理规范

### 命名规范

```
# 推荐格式
项目名-描述-日期时间.扩展名

# 示例
openclaw-20260411132621.png
uetoolkit-image-20260301191908034.png
```

### 目录结构

```
public/blog-images/
├── 项目名1/
│   ├── 图片1.png
│   └── 图片2.png
└── 项目名2/
    └── 图片3.png
```

### 图片优化建议

- 大小：< 500KB
- 格式：WebP > PNG > JPG
- 尺寸：根据实际显示尺寸调整

## 标签规范

### 推荐标签

**技术类**：

- AI, LLM, 深度学习, 机器学习
- Transformer, RAG, MCP
- React, Astro, TailwindCSS
- Python, Rust, TypeScript

**项目类**：

- UE_ToolkitAI, OpenClaw
- 虚幻引擎, Unreal Engine

**工具类**：

- Obsidian, Vercel, Git
- 知识管理, 博客搭建

### 标签命名规则

- 使用中文或英文，保持一致
- 避免过长的标签
- 避免重复含义的标签
- 每篇文章 2-5 个标签

## 辅助脚本

### check-metadata.sh

检查所有文章的元数据完整性

```bash
bash .kiro/skills/content-manager/scripts/check-metadata.sh
```

### check-images.sh

检查图片使用情况和优化建议

```bash
bash .kiro/skills/content-manager/scripts/check-images.sh
```

### generate-report.sh

生成完整的内容管理报告

```bash
bash .kiro/skills/content-manager/scripts/generate-report.sh
```

## 常见问题处理

### Q: 如何批量修复元数据？

A:

1. 运行检查脚本生成报告
2. 确认需要修复的文章
3. 使用 strReplace 批量修改
4. 重新检查验证

### Q: 如何安全删除未使用的图片？

A:

1. 先生成未使用图片列表
2. 人工确认是否真的未使用
3. 备份图片（可选）
4. 执行删除操作

### Q: 如何统一标签？

A:

1. 生成标签使用报告
2. 确定标准标签名称
3. 批量替换相似标签
4. 更新所有相关文章

## 参考资源

### 项目相关

- `scripts/check-metadata.sh` - 元数据检查
- `scripts/check-images.sh` - 图片检查
- `scripts/generate-report.sh` - 生成报告
- `references/metadata-template.md` - 元数据模板

## 成功标准

一次成功的内容管理应该：

- [ ] 所有文章元数据完整
- [ ] 图片使用合理
- [ ] 标签规范统一
- [ ] 没有死链
- [ ] 生成详细报告
- [ ] 用户满意

## 相关技能

- **feature-developer** - 功能开发和 bug 修复
- **style-optimizer** - 样式和 UI 优化
- **blog-writer** - 博客写作
