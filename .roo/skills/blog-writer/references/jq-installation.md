# jq 工具安装指南

`update-tracker.sh` 脚本需要 `jq` 工具来处理 JSON 文件。

## 什么是 jq？

jq 是一个轻量级的命令行 JSON 处理器，用于解析、过滤和转换 JSON 数据。

## 安装方法

### Windows

#### 方法 1: 使用 Chocolatey

```bash
choco install jq
```

#### 方法 2: 手动安装

1. 访问 [jq 官网](https://jqlang.github.io/jq/download/)
2. 下载 Windows 版本 `jq-windows-amd64.exe`
3. 重命名为 `jq.exe`
4. 将文件放到 PATH 环境变量中的目录（如 `C:\Windows\System32`）

#### 方法 3: 使用 Git Bash

如果你安装了 Git for Windows，可以在 Git Bash 中使用：

```bash
# 下载 jq
curl -L -o /usr/bin/jq.exe https://github.com/jqlang/jq/releases/latest/download/jq-windows-amd64.exe
chmod +x /usr/bin/jq.exe
```

### macOS

```bash
brew install jq
```

### Linux (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install jq
```

### Linux (CentOS/RHEL)

```bash
sudo yum install jq
```

## 验证安装

安装完成后，运行以下命令验证：

```bash
jq --version
```

应该输出类似：`jq-1.7.1`

## 基本用法示例

```bash
# 格式化 JSON
echo '{"name":"John","age":30}' | jq '.'

# 提取字段
echo '{"name":"John","age":30}' | jq '.name'

# 数组操作
echo '[1,2,3]' | jq '.[0]'
```

## 在项目中的使用

`update-tracker.sh` 脚本使用 jq 来：

- 添加新的转化记录
- 更新待转化列表
- 查询转化状态
- 生成统计报告

## 替代方案

如果无法安装 jq，可以：

1. 手动编辑 `conversion-tracker.json` 文件
2. 使用 Python 或 Node.js 脚本处理 JSON
3. 使用在线 JSON 编辑器

## 参考资源

- [jq 官方文档](https://jqlang.github.io/jq/)
- [jq 教程](https://jqlang.github.io/jq/tutorial/)
- [jq 在线测试](https://jqplay.org/)
