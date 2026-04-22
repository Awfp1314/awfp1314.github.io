# 多语言支持指南

## 概述

博客项目支持中英文双语，所有面向用户的内容都应该提供中英文两个版本。

## 目录结构

```
src/
├── blog/
│   ├── zh/              # 中文博客文章
│   │   └── 2026/
│   │       └── 3/
│   │           └── 文章名.mdx
│   └── en/              # 英文博客文章
│       └── 2026/
│           └── 3/
│               └── article-name.mdx
├── pages/
│   ├── about.astro      # 中文关于页面
│   ├── index.astro      # 中文主页
│   └── en/              # 英文页面
│       ├── about.astro  # 英文关于页面
│       └── index.astro  # 英文主页
```

## 需要双语的内容

### 1. 博客文章

**中文版本**：`src/blog/zh/YYYY/M/文章名.mdx`
**英文版本**：`src/blog/en/YYYY/M/article-name.mdx`

```yaml
# 中文版本
---
title: "文章标题"
description: "文章描述"
author: HUTAO667
pubDate: "2026-03-15"
tags: ["AI", "深度学习"]
lang: "zh"
---
# 英文版本
---
title: "Article Title"
description: "Article description"
author: HUTAO667
pubDate: "2026-03-15"
tags: ["AI", "Deep Learning"]
lang: "en"
---
```

### 2. 静态页面

#### 关于页面

**中文版本**：`src/pages/about.astro`
**英文版本**：`src/pages/en/about.astro`

#### 主页

**中文版本**：`src/pages/index.astro`
**英文版本**：`src/pages/en/index.astro`

### 3. 导航链接

在 `src/consts.js` 中定义导航链接时，提供中英文版本：

```javascript
export const NAV_LINKS = {
  zh: [
    { href: "/blog", label: "博客" },
    { href: "/about", label: "关于" },
  ],
  en: [
    { href: "/en/blog", label: "Blog" },
    { href: "/en/about", label: "About" },
  ],
};
```

### 4. 组件文本

对于组件中的固定文本，使用语言判断：

```astro
---
const lang = Astro.url.pathname.startsWith('/en/') ? 'en' : 'zh';
const text = {
  zh: { readMore: "阅读更多", publishedOn: "发布于" },
  en: { readMore: "Read More", publishedOn: "Published on" }
};
---

<p>{text[lang].publishedOn} {pubDate}</p>
```

## 翻译原则

### 1. 技术术语

保持技术术语的标准英文：

| 中文       | 英文                         |
| ---------- | ---------------------------- |
| 人工智能   | AI / Artificial Intelligence |
| 深度学习   | Deep Learning                |
| 大语言模型 | Large Language Model (LLM)   |
| 注意力机制 | Attention Mechanism          |
| 向量数据库 | Vector Database              |

### 2. 口语化表达

保持自然的表达方式：

| 中文     | 英文                         |
| -------- | ---------------------------- |
| 说白了   | In simple terms / Simply put |
| 其实就是 | It's essentially / Basically |
| 我觉得   | I think / In my opinion      |
| 就像     | It's like / Just like        |

### 3. 代码和示例

- 代码保持不变
- 注释可以翻译
- 变量名保持英文
- 输出示例根据语言调整

```python
# 中文版本
def search(query):
    """搜索函数"""
    results = find_in_db(query)
    return results

# 英文版本
def search(query):
    """Search function"""
    results = find_in_db(query)
    return results
```

## 语言切换逻辑

### 1. 检测当前语言

```javascript
const currentLang = window.currentLang || "zh";
```

### 2. 切换语言

```javascript
window.toggleLanguage = function () {
  const newLang = window.currentLang === "zh" ? "en" : "zh";
  localStorage.setItem("language", newLang);

  // 跳转到对应语言的页面
  const currentPath = window.location.pathname;
  const newPath =
    newLang === "zh" ? currentPath.replace("/en/", "/") : "/en" + currentPath;

  window.location.href = newPath;
};
```

### 3. 文章链接

中文文章链接到英文版本：

```astro
---
const slug = Astro.params.slug;
const lang = slug.startsWith('zh/') ? 'zh' : 'en';
const altLang = lang === 'zh' ? 'en' : 'zh';
const altSlug = slug.replace(`${lang}/`, `${altLang}/`);
---

<link rel="alternate" hreflang={altLang} href={`/${altSlug}`} />
```

## 开发工作流

### 修改现有页面

1. 确认需要修改的内容
2. 修改中文版本
3. 同步修改英文版本
4. 测试两个版本
5. 提交

### 添加新页面

1. 创建中文版本
2. 创建英文版本
3. 更新导航链接（如果需要）
4. 测试两个版本
5. 提交

### 发布新文章

1. 创建中文文章（`src/blog/zh/...`）
2. AI 自动翻译为英文（`src/blog/en/...`）
3. 检查翻译质量
4. 一起提交

## 常见问题

### Q: 如何判断当前是哪个语言？

A: 通过 URL 路径判断：

- `/en/` 开头 → 英文
- 其他 → 中文

### Q: 旧文章需要翻译吗？

A: 建议逐步翻译，优先翻译：

1. 关于页面
2. 主页
3. 热门文章
4. 新文章

### Q: 翻译质量如何保证？

A:

1. AI 翻译后人工审核
2. 保持技术术语准确
3. 保持口语化风格
4. 测试阅读体验

### Q: 如果英文版本不存在怎么办？

A:

1. 显示提示信息："English version coming soon"
2. 提供返回中文版本的链接
3. 或者直接显示中文版本

## 检查清单

发布前检查：

- [ ] 中文版本内容完整
- [ ] 英文版本内容完整
- [ ] 技术术语翻译准确
- [ ] 代码示例正确
- [ ] 链接都能正常工作
- [ ] 语言切换按钮正常
- [ ] 两个版本构建无错误

## 参考资源

- [Astro i18n 文档](https://docs.astro.build/en/recipes/i18n/)
- [Web 国际化最佳实践](https://www.w3.org/International/questions/qa-i18n)
