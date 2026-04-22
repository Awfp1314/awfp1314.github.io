# Frontmatter 模板

博客文章的 frontmatter 必须包含以下字段。

## 必需字段

### title（标题）

- **类型**：字符串
- **格式**：用引号包裹
- **要求**：简洁直白，避免过于花哨
- **示例**：
  ```yaml
  title: "线性注意力：AI的外挂大脑"
  title: "MCP（Model Context Protocol）模型上下文协议"
  ```

### description（描述）

- **类型**：字符串
- **格式**：用引号包裹
- **要求**：一句话概括文章核心，通常以"说白了"开头
- **示例**：
  ```yaml
  description: "说白了，线性注意力就是给AI加了个U盘，不用每次都把所有代码重新看一遍了"
  description: "MCP是一种协议，它把AI访问外部资源或者工具都统一了标准"
  ```

### author（作者）

- **类型**：字符串
- **格式**：固定值
- **要求**：必须为 `HUTAO667`
- **示例**：
  ```yaml
  author: HUTAO667
  ```

### tags（标签）

- **类型**：数组
- **格式**：用方括号包裹，逗号分隔
- **要求**：3-5 个相关标签
- **示例**：
  ```yaml
  tags: ["AI", "Transformer", "线性注意力", "深度学习"]
  tags: ["AI", "MCP", "LLM"]
  ```

### pubDate（发布日期）

- **类型**：字符串
- **格式**：`YYYY-MM-DD`，用引号包裹
- **要求**：使用原笔记的创建时间，不是当天日期
- **获取方式**：
  - Windows: `Get-Item "文件路径" | Select-Object CreationTime`
  - 使用脚本: `bash .kiro/skills/blog-writer/scripts/get-file-date.sh "文件路径"`
- **示例**：
  ```yaml
  pubDate: "2026-04-08"
  pubDate: "2026-03-15"
  ```

### lang（语言）

- **类型**：字符串
- **格式**：用引号包裹
- **要求**：`zh` 表示中文，`en` 表示英文
- **示例**：
  ```yaml
  lang: "zh"
  lang: "en"
  ```

## 完整示例

### 中文版本

```yaml
---
title: "线性注意力：AI的外挂大脑"
description: "说白了，线性注意力就是给AI加了个U盘，不用每次都把所有代码重新看一遍了"
author: HUTAO667
tags: ["AI", "Transformer", "线性注意力", "深度学习"]
pubDate: "2026-04-08"
lang: "zh"
---
```

### 英文版本

```yaml
---
title: "Linear Attention: AI's External Brain"
description: "Simply put, linear attention gives AI a USB drive so it doesn't have to re-read all the code every time"
author: HUTAO667
tags: ["AI", "Transformer", "Linear Attention", "Deep Learning"]
pubDate: "2026-04-08"
lang: "en"
---
```

## 字段顺序

建议按照以下顺序排列字段（不是强制要求）：

1. title
2. description
3. author
4. tags
5. pubDate
6. lang

## 常见错误

### ❌ 缺少 author 字段

```yaml
---
title: "标题"
description: "描述"
tags: ["标签"]
pubDate: "2026-04-08"
lang: "zh"
---
```

**错误信息**：`author: Required`

**解决方法**：添加 `author: HUTAO667`

### ❌ pubDate 格式错误

```yaml
pubDate: 2026-04-08  # 缺少引号
pubDate: "2026/04/08"  # 使用了斜杠
pubDate: "04-08-2026"  # 顺序错误
```

**正确格式**：`pubDate: "2026-04-08"`

### ❌ tags 格式错误

```yaml
tags: AI, Transformer  # 缺少方括号和引号
tags: ["AI" "Transformer"]  # 缺少逗号
```

**正确格式**：`tags: ["AI", "Transformer"]`

### ❌ lang 值错误

```yaml
lang: "中文"  # 应该用 zh
lang: "english"  # 应该用 en
lang: zh  # 缺少引号
```

**正确格式**：`lang: "zh"` 或 `lang: "en"`

## 验证方法

### 方法 1：使用验证脚本

```bash
bash .kiro/skills/blog-writer/scripts/validate-post.sh "src/blog/2026/4/文章名.mdx"
```

### 方法 2：运行构建

```bash
npm run build
```

如果 frontmatter 有问题，构建会失败并显示错误信息。

## 翻译注意事项

中文版本翻译为英文版本时：

1. **title**：翻译为自然的英文，保持简洁
2. **description**：翻译核心意思，"说白了"可以翻译为 "Simply put" 或 "In simple terms"
3. **author**：保持不变
4. **tags**：翻译为英文，保持技术术语的标准翻译
5. **pubDate**：保持不变
6. **lang**：改为 `"en"`

## 相关文档

- **写作风格指南**：`writing-style-guide.md` - 了解标题和描述的风格要求
- **脚本使用指南**：`scripts-guide.md` - 了解如何使用验证脚本
