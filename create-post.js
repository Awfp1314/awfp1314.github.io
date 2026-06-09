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

function yamlString(value) {
  return JSON.stringify(String(value ?? ''));
}

function normalizeFilename(input) {
  return input
    .trim()
    .replace(/\.mdx$/i, '')
    .replace(/[\\/]+/g, '-')
    .replace(/[^\p{L}\p{N}_-]+/gu, '-')
    .replace(/^-+|-+$/g, '')
    .toLowerCase();
}

async function createPost() {
  console.log('创建新博客文章\n');

  const title = (await question('文章标题: ')).trim();
  const description = (await question('文章描述: ')).trim();
  const tags = await question('标签 (用逗号分隔): ');
  const langInput = (await question('语言 zh/en (默认 zh): ')).trim().toLowerCase();
  const lang = langInput === 'en' ? 'en' : 'zh';
  const alternateSlug = (await question('对应语言文章 slug (可选): ')).trim();
  const filenameInput = await question('文件名 (不含 .mdx): ');
  const filename = normalizeFilename(filenameInput || title);

  if (!title || !description || !filename) {
    throw new Error('标题、描述和文件名不能为空。');
  }
  
  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth() + 1;
  const day = String(now.getDate()).padStart(2, '0');
  const monthStr = String(month).padStart(2, '0');
  const pubDate = `${year}-${monthStr}-${day}`;
  const dir = path.join('src', 'blog', String(year), String(month));

  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  const filePath = path.join(dir, `${filename}.mdx`);
  if (fs.existsSync(filePath)) {
    throw new Error(`目标文件已存在：${filePath}`);
  }
  
  const tagsArray = tags
    .split(',')
    .map(tag => tag.trim())
    .filter(Boolean);
  const tagYaml = `[${tagsArray.map(yamlString).join(', ')}]`;
  const optionalAlternate = alternateSlug ? `alternateSlug: ${yamlString(alternateSlug)}\n` : '';
  
  const content = `---
title: ${yamlString(title)}
description: ${yamlString(description)}
author: HUTAO667
pubDate: ${yamlString(pubDate)}
tags: ${tagYaml}
lang: ${yamlString(lang)}
${optionalAlternate}---

# ${title}

在这里开始写你的文章内容...

## 小节标题

文章正文...
`;

  fs.writeFileSync(filePath, content, 'utf-8');
  console.log(`\n文章创建成功：${filePath}`);
}

createPost()
  .catch(error => {
    console.error(`\n创建失败：${error.message}`);
    process.exitCode = 1;
  })
  .finally(() => rl.close());
