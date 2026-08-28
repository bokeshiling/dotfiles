#!/usr/bin/env bash
set -e

# =============================================================================
# Restore/Install packages from exported lists (Arch Linux, AUR, Flatpak)
# =============================================================================

PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 开始恢复系统软件包..."

# 1. 恢复 Arch 官方软件包
if [ -f "$PKG_DIR/pacman-native.txt" ]; then
    if command -v pacman >/dev/null 2>&1; then
        echo "📥 [1/3] 正在安装 Arch 官方软件包..."
        sudo pacman -S --needed - < "$PKG_DIR/pacman-native.txt"
    else
        echo "⚠️ 跳过官方包安装: 未检测到 pacman"
    fi
fi

# 2. 恢复 AUR 软件包
if [ -f "$PKG_DIR/pacman-aur.txt" ]; then
    AUR_HELPER=""
    if command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    elif command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    fi

    if [ -n "$AUR_HELPER" ]; then
        echo "📥 [2/3] 使用 $AUR_HELPER 安装 AUR 软件包..."
        "$AUR_HELPER" -S --needed - < "$PKG_DIR/pacman-aur.txt"
    else
        echo "⚠️ 未检测到 yay 或 paru，跳过 AUR 包安装。请手动安装 AUR helper 后运行: yay -S --needed - < $PKG_DIR/pacman-aur.txt"
    fi
fi

# 3. 恢复 Flatpak 应用
if [ -f "$PKG_DIR/flatpak.txt" ] && [ -s "$PKG_DIR/flatpak.txt" ]; then
    if command -v flatpak >/dev/null 2>&1; then
        echo "📥 [3/3] 正在安装 Flatpak 应用程序..."
        while IFS= read -r app || [ -n "$app" ]; do
            [ -z "$app" ] && continue
            echo "  -> 安装 Flatpak: $app"
            flatpak install -y flathub "$app" || true
        done < "$PKG_DIR/flatpak.txt"
    else
        echo "⚠️ 未检测到 flatpak，跳过 Flatpak 应用安装"
    fi
fi

echo "✨ 软件包恢复流程执行完成！"
