#!/usr/bin/env bash
set -e

# =============================================================================
# Dotfiles Bootstrap Script (Git + GNU Stow)
# =============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

INSTALL_PACKAGES=false

# 处理命令行参数
for arg in "$@"; do
    case "$arg" in
        -p|--packages)
            INSTALL_PACKAGES=true
            ;;
        -h|--help)
            echo "用法: ./bootstrap.sh [选项]"
            echo ""
            echo "选项:"
            echo "  -p, --packages    在链接配置文件前，先通过 pacman/yay/flatpak 恢复系统软件包"
            echo "  -h, --help        显示帮助信息"
            exit 0
            ;;
        *)
            echo "未知参数: $arg (使用 -h 查看帮助)"
            exit 1
            ;;
    esac
done

# 如果指定了 --packages，先执行软件包恢复
if [ "$INSTALL_PACKAGES" = true ]; then
    if [ -x "$DOTFILES_DIR/packages/install.sh" ]; then
        echo "📦 检测到 --packages 参数，正在启动软件包恢复流程..."
        "$DOTFILES_DIR/packages/install.sh"
    fi
fi

# 检查是否安装了 GNU stow
if ! command -v stow >/dev/null 2>&1; then
    echo "❌ 错误: 未检测到 GNU stow，请先安装 stow (例如: sudo pacman -S stow 或 sudo apt install stow)"
    exit 1
fi

echo "🚀 开始部署 Dotfiles 软链接..."

# 要排除的非配置包目录
EXCLUDE_DIRS=("packages" ".git")

# 获取所有顶层配置包目录
PACKAGES=()
for dir in */; do
    dir="${dir%/}"
    # 忽略隐藏目录
    [[ "$dir" =~ ^\. ]] && continue
    # 忽略非 stow 模块
    skip=false
    for ex in "${EXCLUDE_DIRS[@]}"; do
        if [ "$dir" == "$ex" ]; then
            skip=true
            break
        fi
    done
    [ "$skip" = false ] && PACKAGES+=("$dir")
done

# 遍历每个包并执行 stow
for pkg in "${PACKAGES[@]}"; do
    echo "  -> 正在链接模块: $pkg"
    stow -R --target="$HOME" "$pkg"
done

echo ""
echo "✨ 所有配置文件已成功链接到 $HOME !"
echo "💡 提示: 私人/敏感配置可写入 ~/.zshrc.local 或 ~/.gitconfig.local"
