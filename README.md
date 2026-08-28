# 🛠️ My Dotfiles (Managed by Git + GNU Stow)

这是我的个人配置文件仓库，采用 **Git** 进行版本控制与跨设备同步，配合 **GNU Stow** 管理软链接。

---

## 📁 目录模块一览

| 模块 | 说明 | 对应目标路径 |
| :--- | :--- | :--- |
| `git/` | Git 配置 | `~/.gitconfig` |
| `zsh/` | Zsh 配置 | `~/.zshrc` |
| `bash/` | Bash 配置 | `~/.bashrc`, `~/.bash_profile`, `~/.bash_logout` |
| `nvim/` | Neovim 配置 | `~/.config/nvim/` |
| `vim/` | Vim 配置 | `~/.vimrc` |
| `kitty/` | Kitty 终端 | `~/.config/kitty/` |
| `alacritty/` | Alacritty 终端 | `~/.config/alacritty/` |
| `starship/` | Starship Prompt | `~/.config/starship.toml` |
| `niri/` | Niri 滚动平铺窗口管理器 | `~/.config/niri/` |
| `waybar/` | 状态栏及小脚本 | `~/.config/waybar/` |
| `mako/` | 桌面通知守护进程 | `~/.config/mako/` |
| `swaylock/` | 锁屏配置 | `~/.config/swaylock/` |
| `matugen/` | Material You 动态色彩生成器 | `~/.config/matugen/` |
| `waypaper/` | 壁纸管理器 | `~/.config/waypaper/` |
| `satty/` | 截图与标注工具 | `~/.config/satty/` |
| `scripts/` | 个人实用脚本库 | `~/.config/scripts/` |
| `gtk/` | GTK 主题与 Xsettings | `~/.config/gtk-3.0/`, `gtk-4.0/`, `xsettingsd/`, `~/.gtkrc-2.0` |
| `fontconfig/` | 字体微调与回退规则 | `~/.config/fontconfig/` |
| `fcitx5/` | Fcitx5 输入法配置 | `~/.config/fcitx5/` |
| `cava/` | 终端音频频谱可视化 | `~/.config/cava/` |
| `mpd/` & `ncmpcpp/` | 音乐守护进程与客户端 | `~/.config/mpd/`, `~/.config/ncmpcpp/` |

---

## 🚀 新机器部署方式

### 1. 安装 GNU Stow 与 Git
```bash
# Arch Linux
sudo pacman -S git stow

# Ubuntu / Debian
sudo apt update && sudo apt install git stow
```

### 2. 克隆仓库到家目录
```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

### 3. 一键部署全部配置
```bash
./bootstrap.sh
```

或者手动按需部署单个模块：
```bash
stow nvim
stow zsh
stow niri
```

---

## 🔧 日常维护指南

* **新增/修改配置**：直接在 `~/dotfiles/` 下编辑文件，Git 提交即可。
* **刷新软链接**：`stow -R <模块名>`
* **卸载软链接**：`stow -D <模块名>`
* **私密/单机配置**：放入 `~/.zshrc.local`，已被 `.gitignore` 忽略，不会随仓库上传。
