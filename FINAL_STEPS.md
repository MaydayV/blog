# 最终推送步骤 - 三种方案

博客仓库已完全准备就绪！现在需要推送到 GitHub。

---

## 📋 当前状态

✅ **已完成：**
- Hexo 博客框架 + 中文配置
- README + CONTRIBUTING + 设置指南
- CI/CD + PR模板 + Issue模板
- QUICK_START.sh 一键推送脚本

📍 **位置：** `/home/ubuntu/.openclaw/workspace/blog`

---

## 🚀 方案一：我帮你运行（推荐）

告诉我你的 **GitHub 用户名**，我来执行脚本。

需要：
1. 你的 GitHub 用户名
2. GitHub Token（如果没有，我会引导你生成）

**回复格式：**
```
我的 GitHub 用户名是: xxx
```

---

## 🚀 方案二：你自己运行脚本

执行以下命令：

```bash
cd /home/ubuntu/.openclaw/workspace/blog
./QUICK_START.sh
```

脚本会引导你：
1. 输入 GitHub 用户名
2. 选择认证方式（Token/SSH/密码）
3. 自动推送代码

**需要准备：**
- GitHub 账号
- GitHub Token（生成地址：https://github.com/settings/tokens/new）
  - 勾选权限：`repo`

---

## 🚀 方案三：完全手动操作

### 步骤 1: 生成 GitHub Token

1. 访问 https://github.com/settings/tokens/new
2. Note: 输入描述，如 "Hexo Blog"
3. Expiration: 选择 30 days
4. Scopes: 勾选 `repo` (完整仓库权限)
5. 点击 Generate token
6. ⚠️ **立即复制 Token**（页面关闭后无法再次查看）

### 步骤 2: 在 GitHub 创建仓库

1. 访问 https://github.com/new
2. Repository name: `blog`
3. Description: 基于 Hexo 的个人博客
4. Visibility: Public
5. **不要勾选** "Initialize this repository"
6. 点击 Create repository

### 步骤 3: 推送代码

```bash
# 进入博客目录
cd /home/ubuntu/.openclaw/workspace/blog

# 设置 Git 用户信息（如果尚未设置）
git config user.name "你的用户名"
git config user.email "你的邮箱"

# 添加远程仓库（替换 yourusername 为你的 GitHub 用户名）
git remote add origin https://github.com/yourusername/blog.git

# 推送到 main 分支
# 会提示输入用户名和密码
# 用户名: 你的 GitHub 用户名
# 密码: 粘贴刚才生成的 Token
git branch -M main
git push -u origin main
```

### 步骤 4: 配置 GitHub Pages

1. 访问 `https://github.com/yourusername/blog/settings/pages`
2. Source 选择 **GitHub Actions**
3. 点击 Save
4. 等待 2-3 分钟
5. 访问 `https://yourusername.github.io/blog`

---

## ❓ 遇到问题?

查看详细的故障排除指南：`GITHUB_TOKEN_SETUP.md`

或者参考：
- [GitHub Token 文档](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [Hexo 部署文档](https://hexo.io/docs/one-command-deployment)

---

## 🎉 完成！

推送成功后：
1. 博客将自动部署到 `https://你的用户名.github.io/blog`
2. 可以邀请其他人按 `CONTRIBUTING.md` 的规则投稿
3. 所有更改会自动通过 GitHub Actions 部署

**选择你的方案开始吧！** 🚀
