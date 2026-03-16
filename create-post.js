#!/usr/bin/env node

import fs from 'fs';
import path from 'path';
import readline from 'readline';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function question(query) {
  return new Promise(resolve => rl.question(query, resolve));
}

async function createPost() {
  console.log('📝 创建新博客文章\n');

  const title = await question('文章标题: ');
  const description = await question('文章描述: ');
  const tags = await question('标签 (用逗号分隔): ');
  
  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth() + 1;
  const day = String(now.getDate()).padStart(2, '0');
  const monthStr = String(month).padStart(2, '0');
  const pubDate = `${year}-${monthStr}-${day}`;
  
  const filename = await question('文件名 (不含.mdx): ');
  
  const dir = path.join('src', 'blog', String(year), String(month));
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  const filePath = path.join(dir, `${filename}.mdx`);
  
  const tagsArray = tags.split(',').map(t => `"${t.trim()}"`).join(', ');
  
  const content = `---
title: "${title}"
description: ${description}
author: HUTAO667
tags: [${tagsArray}]
pubDate: '${pubDate}'
---

# ${title}

在这里开始写你的文章内容...

## 小节标题

文章正文...
`;

  fs.writeFileSync(filePath, content, 'utf-8');
  
  console.log(`\n✅ 文章创建成功！`);
  console.log(`📁 位置: ${filePath}`);
  
  rl.close();
}

createPost().catch(console.error);
