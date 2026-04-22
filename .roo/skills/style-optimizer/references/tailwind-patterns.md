# TailwindCSS 常用模式

## 布局模式

### 居中容器

```html
<div class="container mx-auto px-4">
  <!-- 内容 -->
</div>
```

### Flex 居中

```html
<!-- 水平垂直居中 -->
<div class="flex items-center justify-center">
  <!-- 水平居中 -->
  <div class="flex justify-center">
    <!-- 垂直居中 -->
    <div class="flex items-center">
      <!-- 两端对齐 -->
      <div class="flex items-center justify-between"></div>
    </div>
  </div>
</div>
```

### Grid 布局

```html
<!-- 响应式网格 -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  <!-- 自动填充 -->
  <div class="grid grid-cols-[repeat(auto-fit,minmax(250px,1fr))] gap-4"></div>
</div>
```

## 卡片模式

### 基础卡片

```html
<div class="p-6 rounded-lg border border-border bg-card shadow-sm">
  <h3 class="text-lg font-semibold mb-2">标题</h3>
  <p class="text-muted-foreground">内容</p>
</div>
```

### 悬停效果卡片

```html
<div
  class="
  p-6 rounded-lg border border-border bg-card
  hover:shadow-md hover:-translate-y-1
  transition-all duration-200
"
></div>
```

## 按钮模式

### 主要按钮

```html
<button
  class="
  px-4 py-2 rounded-lg
  bg-primary text-white
  hover:bg-primary/90
  transition-colors
"
>
  按钮
</button>
```

### 次要按钮

```html
<button
  class="
  px-4 py-2 rounded-lg
  border border-border
  hover:bg-muted
  transition-colors
"
>
  按钮
</button>
```

## 响应式模式

### 响应式文字

```html
<h1 class="text-2xl md:text-3xl lg:text-4xl"></h1>
```

### 响应式间距

```html
<div class="p-4 md:p-6 lg:p-8"></div>
```

### 响应式显示

```html
<!-- 移动端隐藏 -->
<div class="hidden md:block">
  <!-- 桌面端隐藏 -->
  <div class="block md:hidden"></div>
</div>
```

## 主题模式

### 主题颜色

```html
<div class="bg-background text-foreground">
  <div class="bg-white dark:bg-gray-900">
    <div class="text-gray-900 dark:text-gray-100"></div>
  </div>
</div>
```

### 主题边框

```html
<div class="border border-gray-200 dark:border-gray-800"></div>
```

## 动画模式

### 过渡效果

```html
<div class="transition-colors duration-200">
  <div class="transition-all duration-300">
    <div class="transition-transform duration-200"></div>
  </div>
</div>
```

### 悬停动画

```html
<div class="hover:scale-105 transition-transform">
  <div class="hover:-translate-y-1 transition-transform"></div>
</div>
```
