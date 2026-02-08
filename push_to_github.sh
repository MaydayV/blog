#!/bin/bash
# GitHub 推送脚本
# 支持 Token 认证或 SSH 密钥

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  推送到 GitHub${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# 获取 GitHub 用户名
read -p "请输入您的 GitHub 用户名: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo -e "${RED}错误: GitHub 用户名不能为空${NC}"
    exit 1
fi

REPO_NAME="blog"
REMOTE_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

echo ""
echo -e "${YELLOW}仓库地址: $REMOTE_URL${NC}"
echo ""

# 选择认证方式
echo "请选择认证方式:"
echo "1) GitHub Token (推荐)"
echo "2) SSH 密钥"
echo "3) 手动输入用户名密码"
echo ""
read -p "请选择 [1-3]: " AUTH_METHOD

case $AUTH_METHOD in
    1)
        echo ""
        echo -e "${YELLOW}使用 GitHub Token 认证${NC}"
        echo -e "${BLUE}提示: Token 可以在 https://github.com/settings/tokens 生成${NC}"
        echo -e "${BLUE}需要的权限: repo (完整仓库权限)${NC}"
        echo ""
        read -s -p "请输入 GitHub Token: " GITHUB_TOKEN
        echo ""
        
        if [ -z "$GITHUB_TOKEN" ]; then
            echo -e "${RED}错误: Token 不能为空${NC}"
            exit 1
        fi
        
        # 使用 Token 设置远程仓库
        AUTH_URL="https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME.git"
        git remote remove origin 2>/dev/null || true
        git remote add origin "$AUTH_URL"
        ;;
        
    2)
        echo ""
        echo -e "${YELLOW}使用 SSH 密钥认证${NC}"
        
        # 检查 SSH 密钥
        if [ ! -f "$HOME/.ssh/id_rsa" ] && [ ! -f "$HOME/.ssh/id_ed25519" ]; then
            echo -e "${RED}错误: 未找到 SSH 密钥${NC}"
            echo -e "${YELLOW}请先生成 SSH 密钥:${NC}"
            echo -e "  ssh-keygen -t ed25519 -C \"your_email@example.com\""
            exit 1
        fi
        
        REMOTE_URL="git@github.com:$GITHUB_USERNAME/$REPO_NAME.git"
        git remote remove origin 2>/dev/null || true
        git remote add origin "$REMOTE_URL"
        echo -e "${GREEN}✓ SSH 远程仓库已设置${NC}"
        ;;
        
    3)
        echo ""
        echo -e "${YELLOW}使用用户名密码认证${NC}"
        echo -e "${BLUE}注意: GitHub 已不推荐此方式，建议使用 Token${NC}"
        read -p "请输入 GitHub 密码或 Token: " -s GITHUB_PASS
        echo ""
        
        AUTH_URL="https://$GITHUB_USERNAME:$GITHUB_PASS@github.com/$GITHUB_USERNAME/$REPO_NAME.git"
        git remote remove origin 2>/dev/null || true
        git remote add origin "$AUTH_URL"
        ;;
        
    *)
        echo -e "${RED}错误: 无效的选择${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${YELLOW}→ 检查远程仓库...${NC}"
git remote -v

echo ""
echo -e "${YELLOW}→ 准备推送代码...${NC}"

# 确保在 main 分支
git branch -M main

echo ""
echo -e "${BLUE}================================${NC}"
echo -e "${YELLOW}  开始推送到 GitHub...${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# 推送代码
if git push -u origin main; then
    echo ""
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN}  ✓ 推送成功！${NC}"
    echo -e "${GREEN}================================${NC}"
    echo ""
    echo -e "${BLUE}仓库地址: ${NC}https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo ""
    echo -e "${YELLOW}下一步:${NC}"
    echo -e "  1. 访问 ${GREEN}https://github.com/$GITHUB_USERNAME/$REPO_NAME${NC}"
    echo -e "  2. 点击 ${GREEN}Settings → Pages${NC}"
    echo -e "  3. Source 选择 ${GREEN}GitHub Actions${NC}"
    echo -e "  4. 等待几分钟后访问: ${GREEN}https://$GITHUB_USERNAME.github.io/$REPO_NAME${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}================================${NC}"
    echo -e "${RED}  ✗ 推送失败${NC}"
    echo -e "${RED}================================${NC}"
    echo ""
    echo -e "${YELLOW}常见原因:${NC}"
    echo -e "  - Token 或密码错误"
    echo -e "  - 仓库不存在（需要先创建仓库）"
    echo -e "  - 网络连接问题"
    echo ""
    echo -e "${YELLOW}解决方案:${NC}"
    echo -e "  1. 确认 GitHub Token/密码正确"
    echo -e "  2. 确认仓库已在 GitHub 创建: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo -e "  3. 检查网络连接"
    echo ""
fi
