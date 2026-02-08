---
title: "Hexo + GitHub Pages 快速搭建个人博客"
date: 2024-01-15 10:00:00
updated: 2024-01-16 15:30:00
author: "Colin"
tags:
  - Hexo
  - GitHub Pages
  - 教程
categories:
  - 技术教程
excerpt: "本文详细介绍如何使用 Hexo 框架和 GitHub Pages 免费搭建一个个人博客，从零开始，一步步教你完成搭建。"
---

## 前言

在这个信息爆炸的时代，拥有一个属于自己的博客网站，不仅可以记录学习和生活的点滴，还能与他人分享知识和经验。本文将手把手教你如何使用 **Hexo** 和 **GitHub Pages** 免费搭建一个个人博客。

## 准备工作

### 需要安装的工具

- [Node.js](https://nodejs.org/) (>= 14.0)
- [Git](https://git-scm.com/)
- 一个 [GitHub](https://github.com/) 账号

### 验证安装

```bash
# 检查 Node.js 版本
node -v

# 检查 npm 版本
npm -v

# 检查 Git 版本
git --version
```

## 搭建步骤

### 1. 安装 Hexo

打开终端，执行以下命令：

```bash
npm install -g hexo-cli
```

### 2. 初始化博客

```bash
# 创建博客文件夹
hexo init my-blog
cd my-blog

# 安装依赖
npm install
```

### 3. 本地预览

```bash
hexo server
```

打开浏览器访问 `http://localhost:4000`，即可看到你的博客。

## 部署到 GitHub Pages

### 1. 创建 GitHub 仓库

在 GitHub 上创建一个名为 `yourusername.github.io` 的仓库（将 `yourusername` 替换为你的 GitHub 用户名）。

### 2. 配置部署

编辑博客目录下的 `_config.yml` 文件：

```yaml
deploy:
  type: git
  repo: https://github.com/yourusername/yourusername.github.io.git
  branch: main
```

### 3. 部署

```bash
# 安装部署插件
npm install hexo-deployer-git --save

# 生成静态文件并部署
hexo clean && hexo deploy
```

等待几分钟后，访问 `https://yourusername.github.io` 即可看到你的博客。

## 总结

通过以上步骤，我们成功搭建了一个基于 Hexo 和 GitHub Pages 的个人博客。整个过程免费且简单，非常适合想要拥有个人网站的初学者。

如果你想进一步美化博客，可以：

- 更换 Hexo [主题](https://hexo.io/themes/)
- 配置自定义域名
- 添加评论系统
- 集成统计分析

祝你的博客之旅愉快！

---

**参考链接：**

- [Hexo 官方文档](https://hexo.io/docs/)
- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [Markdown 语法指南](https://www.markdownguide.org/)
