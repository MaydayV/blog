# GitHub Token 设置指南

## 为什么需要 Token?

GitHub 在 2021 年后不再支持密码认证，需要使用 **Personal Access Token (PAT)** 进行命令行操作。

## 创建 Token 步骤

### 1. 打开 Token 设置页面
访问: https://github.com/settings/tokens/new

或者手动导航:
- 点击右上角头像 → **Settings**
- 左侧菜单最下方 → **Developer settings**
- **Personal access tokens** → **Tokens (classic)**
- 点击 **Generate new token (classic)**

### 2. 配置 Token

**Note**: 输入描述，例如:
```
Hexo Blog Deploy
```

**Expiration**: 选择过期时间
- 推荐: **30 days** (30天后需要重新生成)
- 或者: **No expiration** (永久有效，但安全性较低)

**Scopes**: 勾选权限
必须勾选:
- ✅ **repo** (完整仓库权限)
  - ✅ repo:status
  - ✅ repo_deployment
  - ✅ public_repo
  - ✅ repo:invite
  - ✅ security_events

可选勾选:
- ✅ **workflow** (如果需要修改 GitHub Actions)

### 3. 生成并复制 Token

1. 滚动到页面底部
2. 点击 **Generate token**
3. ⚠️ **立即复制 Token**（页面关闭后无法再次查看）

Token 格式示例:
```
ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 4. 使用 Token

#### 方式 1: 临时使用（推荐，安全）

在推送时输入 Token 作为密码:

```bash
git push origin main
# 用户名: 你的 GitHub 用户名
# 密码: 粘贴 Token
```

#### 方式 2: 缓存 Token（方便但安全性较低）

```bash
# 启用凭证缓存（默认 15 分钟）
git config --global credential.helper cache

# 或者永久存储（不推荐在共享机器上使用）
git config --global credential.helper store
```

#### 方式 3: 使用 .netrc 文件（Linux/Mac）

```bash
# 创建/编辑 .netrc 文件
cat >> ~/.netrc << EOF
machine github.com
login YOUR_GITHUB_USERNAME
password YOUR_TOKEN
EOF

# 设置权限
chmod 600 ~/.netrc
```

## 安全建议

### ✅ 推荐做法
- 设置 Token 过期时间（30-90 天）
- 最小权限原则（只勾选必要的权限）
- 定期轮换 Token
- 不要将 Token 提交到代码仓库

### ❌ 避免做法
- 使用永久有效的 Token
- 在公共/共享机器上存储 Token
- 将 Token 硬编码在脚本中
- 分享 Token 给他人

## 故障排除

### 问题 1: 推送时提示 "Authentication failed"

**原因**: Token 错误或过期

**解决**:
1. 检查 Token 是否正确复制
2. 在 GitHub 上检查 Token 是否过期
3. 重新生成 Token

### 问题 2: 提示 "Permission denied"

**原因**: Token 权限不足

**解决**:
1. 检查 Token 是否勾选了 `repo` 权限
2. 确认对目标仓库有写权限

### 问题 3: 提示 "Repository not found"

**原因**: 仓库不存在或无权限访问

**解决**:
1. 确认仓库已在 GitHub 创建
2. 确认仓库 URL 正确
3. 检查是否有权限访问

## 相关链接

- [GitHub Token 文档](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [Git 凭证存储](https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git)
- [Hexo 部署文档](https://hexo.io/docs/one-command-deployment)

---

**生成 Token 后，你可以：**
1. 运行 `./push_to_github.sh` 脚本，按提示输入 Token
2. 或者手动执行 git push，在密码提示处粘贴 Token
