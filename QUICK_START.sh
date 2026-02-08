#!/bin/bash
# GitHub 博客快速设置脚本
# 使用方法: ./QUICK_START.sh your-github-username

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查参数
if [ $# -eq 0 ]; then
    echo -e "${RED}错误: 请提供 GitHub 用户名${NC}"
    echo "用法: ./QUICK_START.sh your-github-username"
    echo "示例: ./QUICK_START.sh tuhaov"
    exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME="blog"

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  Hexo 博客 GitHub 快速设置${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# 检查 git
echo -e "${YELLOW}→ 检查 Git 环境...${NC}"
if ! command -v git &> /dev/null; then
    echo -e "${RED}错误: Git 未安装${NC}"
    exit 1
fi

# 检查 git 配置
echo -e "${YELLOW}→ 检查 Git 配置...${NC}"
GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
    echo -e "${YELLOW}Git 用户信息未配置，正在设置...${NC}"
    git config --global user.name "$GITHUB_USERNAME"
    git config --global user.email "$GITHUB_USERNAME@users.noreply.github.com"
    echo -e "${GREEN}✓ Git 配置完成${NC}"
else
    echo -e "${GREEN}✓ Git 已配置: $GIT_NAME <$GIT_EMAIL>${NC}"
fi

# 检查远程仓库
echo -e "${YELLOW}→ 检查远程仓库配置...${NC}"
REMOTE_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

if git remote get-url origin &> /dev/null; then
    CURRENT_URL=$(git remote get-url origin)
    echo -e "${YELLOW}远程仓库已存在: $CURRENT_URL${NC}"
    read -p "是否更新为新的仓库地址? (y/N): " UPDATE_REMOTE
    if [[ $UPDATE_REMOTE =~ ^[Yy]$ ]]; then
        git remote set-url origin "$REMOTE_URL"
        echo -e "${GREEN}✓ 远程仓库已更新${NC}"
    fi
else
    git remote add origin "$REMOTE_URL"
    echo -e "${GREEN}✓ 远程仓库已添加: $REMOTE_URL${NC}"
fi

echo ""
echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}  本地配置完成！${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# 显示后续步骤
echo -e "${YELLOW}📋 请按以下步骤在 GitHub 上创建仓库并推送:${NC}"
echo ""
echo -e "${BLUE}步骤 1:${NC} 在浏览器中打开以下链接创建仓库:"
echo -e "   ${GREEN}https://github.com/new${NC}"
echo ""
echo -e "   填写信息:"
echo -e "   - Repository name: ${YELLOW}blog${NC}"
echo -e "   - Description: ${YELLOW}基于 Hexo 的个人博客${NC}"
echo -e "   - Visibility: ${YELLOW}Public${NC}"
echo -e "   - 不要勾选 ${YELLOW}Initialize this repository${NC}"
echo ""
echo -e "   然后点击 ${GREEN}Create repository${NC}"
echo ""

read -p "按 Enter 继续..."

echo ""
echo -e "${BLUE}步骤 2:${NC} 推送本地代码到 GitHub"
echo ""
echo -e "   运行以下命令:${NC}"
echo ""
echo -e "   ${YELLOW}cd $(pwd)${NC}"
echo -e "   ${YELLOW}git branch -M main${NC}"
echo -e "   ${YELLOW}git push -u origin main${NC}"
echo ""

read -p "是否现在执行推送? (y/N): " PUSH_NOW

if [[ $PUSH_NOW =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}→ 正在推送代码...${NC}"
    git branch -M main
    if git push -u origin main; then
        echo -e "${GREEN}✓ 推送成功！${NC}"
        echo ""
        echo -e "${BLUE}步骤 3:${NC} 配置 GitHub Pages"
        echo ""
        echo -e "   1. 打开: ${GREEN}https://github.com/$GITHUB_USERNAME/$REPO_NAME/settings/pages${NC}"
        echo -e "   2. Source 选择: ${YELLOW}GitHub Actions${NC}"
        echo -e "   3. 点击 Save"
        echo ""
        echo -e "   等待 2-3 分钟后访问: ${GREEN}https://$GITHUB_USERNAME.github.io/$REPO_NAME${NC}"
    else
        echo -e "${RED}✗ 推送失败，请检查网络或权限${NC}"
        echo -e "${YELLOW}可能需要先在 GitHub 上创建仓库${NC}"
    fi
else
    echo -e "${YELLOW}已跳过推送步骤${NC}"
    echo -e "稍后请手动运行: ${YELLOW}git push -u origin main${NC}"
fi

echo ""
echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}  设置完成！${NC}"
echo -e "${BLUE}================================${NC}"
echo ""
