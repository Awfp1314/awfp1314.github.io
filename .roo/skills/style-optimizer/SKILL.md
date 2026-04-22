---
name: style-optimizer
description: 博客项目的样式和UI优化技能，当用户提出样式调整、响应式布局、主题优化等需求时激活
---

# 样式优化技能

这个技能专门处理博客项目的样式调整、UI 优化、响应式布局和主题相关的问题。

## 激活条件

当用户提出以下需求时激活：

- "调整XX样式"
- "优化XX布局"
- "修复XX显示问题"
- "改进XX主题"
- "适配移动端"
- 或其他明确的样式相关需求

**不激活的情况**：

- 功能开发（使用 feature-developer）
- 内容管理（使用 content-manager）
- 写博客文章（使用 blog-writer）

## 注意事项

### 多语言样式支持

在调整样式时，需要考虑中英文显示差异：

- **字体**: 中文字体通常比英文字体更大，需要调整行高和间距
- **文本长度**: 英文单词可能比中文更长，需要考虑换行和溢出
- **排版**: 确保两种语言的排版都美观
- **测试**: 在两种语言下都要测试样式效果

## 项目样式技术栈

- **CSS 框架**: TailwindCSS 3.4
- **主题系统**: CSS Variables + dark class
- **响应式**: Mobile-first 设计
- **字体**: Google Fonts (Roboto Mono, JetBrains Mono)
- **图标**: Lucide Astro

## TailwindCSS 配置

项目使用的主要配置：

```javascript
// tailwind.config.mjs
{
  darkMode: 'class',  // 使用 class 模式切换主题
  theme: {
    extend: {
      colors: {
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: 'hsl(var(--primary))',
        muted: 'hsl(var(--muted))',
        // ... 更多颜色
      }
    }
  }
}
```

## 工作流程

### Step 1：问题识别

1. **理解需求**：
   - 具体是什么样式问题？
   - 在哪个页面/组件出现？
   - 影响哪些设备（桌面/移动）？
   - 在哪个主题下出现（浅色/深色）？

2. **复现问题**：
   - 查看相关页面代码
   - 识别问题元素
   - 分析当前样式

3. **确认范围**：
   - 是局部样式还是全局样式？
   - 是否影响其他组件？
   - 是否需要修改配置？

**示例输出**：

```
我理解你的需求是：[样式问题描述]

问题分析：
- 出现位置：[页面/组件]
- 影响设备：[桌面/移动/全部]
- 影响主题：[浅色/深色/全部]
- 问题原因：[原因分析]

解决方案：
1. 修改 [文件名] 的样式
2. 调整 [具体样式属性]
3. 测试不同设备和主题
```

### Step 2：样式分析

1. **定位样式代码**：
   - 组件内联样式（`<style>` 标签）
   - TailwindCSS 类名
   - 全局样式（`global.css`）
   - TailwindCSS 配置

2. **分析样式层级**：
   - 检查样式优先级
   - 识别样式冲突
   - 查看继承关系

3. **检查响应式**：
   - 移动端样式（`sm:`, `md:`, `lg:`）
   - 断点设置是否合理
   - 是否需要调整

4. **检查主题适配**：
   - 浅色主题样式
   - 深色主题样式（`dark:`）
   - 颜色变量使用

**参考文件**：

- `references/tailwind-patterns.md` - TailwindCSS 常用模式
- `references/responsive-guide.md` - 响应式设计指南
- `references/theme-guide.md` - 主题系统指南

### Step 3：实现样式

1. **编写样式代码**：
   - 优先使用 TailwindCSS 类名
   - 必要时使用自定义样式
   - 遵循项目样式规范

2. **样式规范**：
   - 使用语义化类名
   - 保持类名顺序一致
   - 避免过度嵌套
   - 使用 CSS 变量

3. **响应式处理**：

   ```html
   <!-- Mobile-first 设计 -->
   <div
     class="
     text-sm md:text-base lg:text-lg
     p-4 md:p-6 lg:p-8
     grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3
   "
   ></div>
   ```

4. **主题适配**：
   ```html
   <!-- 同时支持浅色和深色主题 -->
   <div
     class="
     bg-white dark:bg-gray-900
     text-gray-900 dark:text-gray-100
     border-gray-200 dark:border-gray-800
   "
   ></div>
   ```

**参考脚本**：

- `scripts/check-responsive.sh` - 检查响应式样式
- `scripts/check-theme.sh` - 检查主题适配

### Step 4：测试验证

1. **视觉测试**：
   - 检查样式是否符合预期
   - 检查对齐和间距
   - 检查颜色和字体

2. **响应式测试**：
   - 测试移动端（< 768px）
   - 测试平板端（768px - 1024px）
   - 测试桌面端（> 1024px）

3. **主题测试**：
   - 测试浅色主题
   - 测试深色主题
   - 测试主题切换

4. **浏览器测试**：
   - Chrome/Edge
   - Firefox
   - Safari（如果可能）

5. **多语言测试**：
   - 测试中文内容显示
   - 测试英文内容显示
   - 检查文本长度差异是否影响布局

6. **检查清单**：
   - [ ] 样式符合预期
   - [ ] 响应式正常
   - [ ] 主题适配正常
   - [ ] 中英文显示都正常
   - [ ] 没有破坏其他样式
   - [ ] 构建无错误

### Step 5：用户确认

1. **展示修改**：

   ```
   我已经完成了样式调整：

   修改的文件：
   - [文件名] - [修改说明]

   主要改动：
   1. [改动描述]
   2. [改动描述]

   测试结果：
   - ✅ 桌面端显示正常
   - ✅ 移动端显示正常
   - ✅ 浅色主题正常
   - ✅ 深色主题正常
   ```

2. **提供截图说明**（如果需要）

3. **根据反馈调整**

### Step 6：Git 提交

**用户确认满意后**：

```bash
git add [修改的文件]
git commit -m "style: [样式修改描述]"
git push
```

## 常见样式场景

### 场景 1：响应式布局调整

**示例**：移动端标签换行

```html
<!-- 修改前 -->
<div class="flex gap-2">{tags.map(tag => <span>{tag}</span>)}</div>

<!-- 修改后 -->
<div class="flex flex-wrap gap-2">{tags.map(tag => <span>{tag}</span>)}</div>
```

### 场景 2：主题颜色调整

**示例**：优化深色主题代码块

```css
/* 修改前 */
pre {
  background: #1e1e1e;
}

/* 修改后 */
pre {
  background: hsl(var(--muted));
}

.dark pre {
  background: hsl(var(--muted) / 0.5);
}
```

### 场景 3：间距和对齐

**示例**：调整卡片间距

```html
<!-- 修改前 -->
<div class="grid grid-cols-3 gap-4">
  <!-- 修改后 -->
  <div
    class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6"
  ></div>
</div>
```

### 场景 4：动画和过渡

**示例**：添加平滑过渡

```html
<button
  class="
  bg-primary text-white
  hover:bg-primary/90
  transition-colors duration-200
"
></button>
```

## TailwindCSS 最佳实践

### 1. 使用语义化类名

```html
<!-- 好 -->
<div class="container mx-auto px-4">
  <!-- 不好 -->
  <div class="w-full max-w-7xl ml-auto mr-auto pl-4 pr-4"></div>
</div>
```

### 2. 保持类名顺序

推荐顺序：布局 → 尺寸 → 间距 → 颜色 → 字体 → 其他

```html
<div
  class="
  flex items-center justify-between
  w-full h-12
  px-4 py-2
  bg-white text-gray-900
  text-sm font-medium
  rounded-lg shadow-sm
  hover:bg-gray-50
  transition-colors
"
></div>
```

### 3. 使用 @apply 提取重复样式

```css
/* global.css */
.btn-primary {
  @apply px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors;
}
```

### 4. 使用 CSS 变量

```css
/* 定义变量 */
:root {
  --primary: 220 90% 56%;
}

.dark {
  --primary: 220 90% 66%;
}

/* 使用变量 */
.text-primary {
  color: hsl(var(--primary));
}
```

## 响应式设计指南

### 断点

```
sm: 640px   - 手机横屏
md: 768px   - 平板
lg: 1024px  - 小屏笔记本
xl: 1280px  - 桌面
2xl: 1536px - 大屏
```

### Mobile-First 原则

```html
<!-- 默认移动端，然后逐步增强 -->
<div
  class="
  text-sm md:text-base lg:text-lg
  p-4 md:p-6 lg:p-8
"
></div>
```

### 常用响应式模式

```html
<!-- 响应式网格 -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  <!-- 响应式 Flex -->
  <div class="flex flex-col md:flex-row gap-4">
    <!-- 响应式隐藏/显示 -->
    <div class="hidden md:block">桌面端显示</div>
    <div class="block md:hidden">移动端显示</div>
  </div>
</div>
```

## 主题系统指南

### 颜色变量

```css
:root {
  --background: 0 0% 100%;
  --foreground: 0 0% 3.9%;
  --primary: 220 90% 56%;
  --muted: 0 0% 96.1%;
}

.dark {
  --background: 0 0% 3.9%;
  --foreground: 0 0% 98%;
  --primary: 220 90% 66%;
  --muted: 0 0% 14.9%;
}
```

### 使用主题颜色

```html
<!-- 使用 CSS 变量 -->
<div class="bg-background text-foreground">
  <!-- 使用 dark: 前缀 -->
  <div class="bg-white dark:bg-gray-900"></div>
</div>
```

### 主题切换逻辑

```javascript
// 切换主题
document.documentElement.classList.toggle("dark");

// 保存主题
localStorage.setItem("theme", isDark ? "dark" : "light");
```

## 常见问题处理

### Q: 样式不生效？

A:

1. 检查类名拼写
2. 检查样式优先级
3. 检查是否被其他样式覆盖
4. 清除缓存重新构建

### Q: 深色主题颜色不对？

A:

1. 检查是否使用了 `dark:` 前缀
2. 检查 CSS 变量定义
3. 检查主题切换逻辑

### Q: 移动端布局错乱？

A:

1. 检查响应式断点
2. 检查是否使用 Mobile-first
3. 测试不同屏幕尺寸

### Q: 样式在构建后丢失？

A:

1. 检查 TailwindCSS 配置的 content 路径
2. 确保类名是完整的字符串
3. 避免动态拼接类名

## 参考资源

### 官方文档

- [TailwindCSS 文档](https://tailwindcss.com/docs)
- [TailwindCSS 深色模式](https://tailwindcss.com/docs/dark-mode)
- [TailwindCSS 响应式设计](https://tailwindcss.com/docs/responsive-design)

### 项目相关

- `references/tailwind-patterns.md` - TailwindCSS 模式
- `references/responsive-guide.md` - 响应式指南
- `references/theme-guide.md` - 主题指南
- `scripts/` - 辅助脚本

## 成功标准

一次成功的样式优化应该：

- [ ] 样式符合设计预期
- [ ] 响应式适配良好
- [ ] 主题切换正常
- [ ] 没有破坏其他样式
- [ ] 代码简洁规范
- [ ] 用户满意

## 相关技能

- **feature-developer** - 功能开发和 bug 修复
- **content-manager** - 内容管理
- **blog-writer** - 博客写作
