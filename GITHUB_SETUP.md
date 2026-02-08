# GitHub 仓库设置指南

## 方案 1: 手动创建（推荐，5分钟完成）

### 步骤 1: 在 GitHub 创建仓库

1. 打开 https://github.com/new
2. 填写仓库信息：
   - **Repository name**: `blog` （或你喜欢的名字）
   - **Description**: 基于 Hexo 的个人博客
   - **Visibility**: Public
   - **Initialize**: 不要勾选任何选项
3. 点击 **Create repository**

### 步骤 2: 推送本地代码

在本地博客目录执行以下命令：

```bash
# 进入博客目录
cd /home/ubuntu/.openclaw/workspace/blog

# 添加远程仓库（替换 yourusername 为你的 GitHub 用户名）
git remote add origin https://github.com/yourusername/blog.git

# 查看远程仓库配置
git remote -v

# 推送代码到 main 分支
git branch -M main
git push -u origin main
```

### 步骤 3: 配置 GitHub Pages

1. 在 GitHub 仓库页面，点击 **Settings**
2. 左侧菜单选择 **Pages**
3. **Source** 选择 **GitHub Actions**
4. 保存设置

### 步骤 4: 验证部署

1. 等待几分钟（首次部署约 2-3 分钟）
2. 访问 `https://yourusername.github.io/blog`
3. 应该能看到博客首页

---

## 方案 2: 使用 GitHub CLI（如果你有 gh）

```bash
# 登录 GitHub
gitHub auth login

# 创建仓库并推送
cd /home/ubuntu/.openclaw/workspace/blog
gh repo create blog --public --source=. --push

# 启用 GitHub Pages
gitHub repo edit --enable-pages --pages-branch=gh-pages
```

---

## 方案 3: 使用 GitHub Token（自动化）

如果你有一个 **GitHub Personal Access Token**，我可以帮你自动创建仓库。

Token 需要以下权限：
- `repo` - 创建仓库
- `workflow` - 配置 GitHub Actions

**使用方法：**
1. 在 GitHub 生成 Token: https://github.com/settings/tokens/new
2. 选择权限: `repo`, `workflow`
3. 将 Token 提供给我
4. 我会自动完成：创建仓库 → 推送代码 → 配置 Pages

---

## 常见问题

### Q: 推送时提示认证失败？
A: 需要配置 Git 凭证。运行：
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Q: 部署后页面 404？
A: 等待 2-3 分钟，首次部署需要较长时间。如果仍 404，检查 GitHub Actions 是否运行成功。

### Q: 如何自定义域名？
A: 在 `source/` 目录添加 `CNAME` 文件，内容为您的域名。

---

## 需要帮助？

如果操作过程中遇到问题，可以：
1. 查看详细的 [CONTRIBUTING.md](./CONTRIBUTING.md)
2. 提交 [Issue](https://github.com/yourusername/blog/issues)

---

**选择适合你的方案开始吧！** 🚀
