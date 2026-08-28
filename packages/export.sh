#!/usr/bin/env bash
set -e

# =============================================================================
# Export installed package lists (Arch Linux, AUR, Flatpak)
# =============================================================================

PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📦 正在导出系统已安装的软件包列表..."

# 1. 导出 Arch 官方仓库中显式安装的包
if command -v pacman >/dev/null 2>&1; then
    pacman -Qqen | sort > "$PKG_DIR/pacman-native.txt"
    echo "  -> 已导出官方软件包列表: $(wc -l < "$PKG_DIR/pacman-native.txt") 个"
    
    # 2. 导出 AUR (外国源) 显式安装的包
    pacman -Qqem | sort > "$PKG_DIR/pacman-aur.txt"
    echo "  -> 已导出 AUR 软件包列表: $(wc -l < "$PKG_DIR/pacman-aur.txt") 个"
fi

# 3. 导出 Flatpak 应用程序列表
if command -v flatpak >/dev/null 2>&1; then
    flatpak list --app --columns=application 2>/dev/null | grep -v '^[[:space:]]*$' | grep -v '^应用程序 ID' | grep -v '^Application ID' | sort > "$PKG_DIR/flatpak.txt"
    echo "  -> 已导出 Flatpak 应用列表: $(wc -l < "$PKG_DIR/flatpak.txt") 个"
fi

echo "✨ 软件包列表导出完成！文件保存在: $PKG_DIR"
