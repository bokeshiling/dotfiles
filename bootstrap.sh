#!/usr/bin/env bash
set -e

# =============================================================================
# Dotfiles Bootstrap Script (Git + GNU Stow)
# =============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# 检查是否安装了 GNU stow
if ! command -v stow >/dev/null 2>&1; then
    echo "❌ 错误: 未检测到 GNU stow，请先安装 stow (例如: sudo pacman -S stow 或 sudo apt install stow)"
    exit 1
fi

echo "🚀 开始部署 Dotfiles..."

# 获取所有顶层包目录（排除以 . 开头的隐藏目录）
PACKAGES=()
for dir in */; do
    dir="${dir%/}"
    if [[ ! "$dir" =~ ^\. ]]; then
        PACKAGES+=("$dir")
    fi
done

# 遍历每个包并执行 stow
for pkg in "${PACKAGES[@]}"; do
    echo "📦 正在链接模块: $pkg"
    stow -R --target="$HOME" "$pkg"
done

echo ""
echo "✨ 所有配置文件已成功链接到 $HOME !"
echo "💡 提示: 私人/敏感配置可写入 ~/.zshrc.local 或 ~/.gitconfig.local"
