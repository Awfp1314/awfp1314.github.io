# 脚本使用指南

本技能包含多个辅助脚本，用于自动化博客转化流程中的各个环节。

## 脚本列表

### 1. update-tracker.sh - 转化跟踪管理

**位置**：`.kiro/skills/blog-writer/scripts/update-tracker.sh`

**用途**：管理笔记转化状态，记录已转化、待转化和跳过的笔记。

**依赖**：需要安装 `jq` 工具（JSON 处理）

**使用方法**：

```bash
# 查看转化状态统计
bash .kiro/skills/blog-writer/scripts/update-tracker.sh status

# 列出已转化的笔记
bash .kiro/skills/blog-writer/scripts/update-tracker.sh list-converted

# 列出待转化的笔记
bash .kiro/skills/blog-writer/scripts/update-tracker.sh list-pending

# 列出跳过的笔记
bash .kiro/skills/blog-writer/scripts/update-tracker.sh list-skipped

# 添加已转化笔记
bash .kiro/skills/blog-writer/scripts/update-tracker.sh add-converted \
  "知识库/02_Notes/笔记名.md" \
  "src/blog/2026/3/文章名.mdx"

# 添加待转化笔记
bash .kiro/skills/blog-writer/scripts/update-tracker.sh add-pending \
  "知识库/02_Notes/笔记名.md" \
  "high" \
  "转化原因"

# 添加跳过笔记
bash .kiro/skills/blog-writer/scripts/update-tracker.sh add-skipped \
  "知识库/02_Notes/笔记名.md" \
  "跳过原因"
```

**在工作流中的使用**：

- Step 1（检查知识库）：使用 `list-pending` 和 `list-converted` 查看状态
- Step 6（更新跟踪）：使用 `add-converted` 记录转化完成的笔记

**注意事项**：

- Windows 环境下可能需要 Git Bash 或 WSL
- 如果没有 jq，可以直接手动编辑 `conversion-tracker.json`

---

### 2. validate-post.sh - 博客文章验证

**位置**：`.kiro/skills/blog-writer/scripts/validate-post.sh`

**用途**：验证博客文章的 frontmatter 格式是否正确。

**使用方法**：

```bash
# 验证单个文章
bash .kiro/skills/blog-writer/scripts/validate-post.sh "src/blog/2026/3/文章名.mdx"

# 验证多个文章
bash .kiro/skills/blog-writer/scripts/validate-post.sh "src/blog/2026/3/*.mdx"
```

**检查项**：

- title 字段是否存在
- description 字段是否存在
- author 字段是否存在（必须为 HUTAO667）
- pubDate 字段是否存在且格式正确（YYYY-MM-DD）
- tags 字段是否存在
- lang 字段是否存在（zh 或 en）

**在工作流中的使用**：

- Step 6（构建检查前）：可选，用于快速验证 frontmatter 格式

---

### 3. translate-post.sh - 文章翻译辅助

**位置**：`.kiro/skills/blog-writer/scripts/translate-post.sh`

**用途**：辅助将中文博客翻译为英文版本（需要手动翻译内容）。

**使用方法**：

```bash
# 创建英文版本模板
bash .kiro/skills/blog-writer/scripts/translate-post.sh \
  "src/blog/2026/3/文章名.mdx" \
  "src/blog/2026/3/Article-Name.mdx"
```

**功能**：

- 复制中文文章结构
- 提示需要翻译的部分
- 自动更新 lang 字段为 "en"

**在工作流中的使用**：

- Step 3（转化为博客）：创建英文版本时使用
- 注意：脚本只创建模板，实际翻译需要手动完成或使用 AI

---

### 4. get-file-date.sh - 获取文件日期

**位置**：`.kiro/skills/blog-writer/scripts/get-file-date.sh`

**用途**：获取笔记文件的创建时间，用于设置博客的 pubDate。

**使用方法**：

```bash
# 获取文件创建时间
bash .kiro/skills/blog-writer/scripts/get-file-date.sh "知识库/02_Notes/笔记名.md"
```

**输出格式**：YYYY-MM-DD

**在工作流中的使用**：

- Step 3（转化为博客）：确定 pubDate 时使用
- 优先使用创建时间，如果无法获取则使用修改时间

---

## Windows 环境注意事项

由于这些脚本是 Bash 脚本，在 Windows 环境下需要：

1. **使用 Git Bash**：
   - 如果安装了 Git for Windows，可以使用 Git Bash 运行脚本
   - 在 Kiro 中，shell 设置为 bash 时会自动使用 Git Bash

2. **安装 jq（可选）**：
   - update-tracker.sh 需要 jq 工具
   - 如果没有 jq，可以直接手动编辑 JSON 文件

3. **替代方案**：
   - 如果脚本无法运行，可以直接手动操作：
     - 手动编辑 `conversion-tracker.json`
     - 手动验证 frontmatter 格式
     - 手动创建英文版本文件

---

## 脚本开发指南

如果需要添加新的脚本：

1. **命名规范**：使用 kebab-case，如 `new-script.sh`
2. **位置**：放在 `.kiro/skills/blog-writer/scripts/` 目录
3. **文档**：在本文件中添加使用说明
4. **错误处理**：脚本应该有清晰的错误提示
5. **跨平台**：考虑 Windows 环境的兼容性

---

## 常见问题

### Q: 脚本提示 "command not found"

A: 确保使用 bash 运行脚本，而不是 PowerShell 或 CMD。

### Q: jq 工具安装失败

A: 可以跳过脚本，直接手动编辑 `conversion-tracker.json` 文件。

### Q: 脚本权限问题

A: 在 Git Bash 中运行：`chmod +x .kiro/skills/blog-writer/scripts/*.sh`
