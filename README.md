# 🪐 bokeshiling's Dotfiles

> 基于 **Arch Linux + Niri + GNU Stow** 的扁平化个人配置与系统软件包管理方案（1:1 镜像 `$HOME` 架构）。

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?logo=arch-linux&logoColor=white&style=flat-square)
![Wayland](https://img.shields.io/badge/Wayland-Niri-blue?style=flat-square)
![GNU Stow](https://img.shields.io/badge/Symlink-GNU_Stow-yellow?style=flat-square)
![Shell](https://img.shields.io/badge/Shell-Zsh_%26_Bash-green?style=flat-square)
![Editor](https://img.shields.io/badge/Editor-Neovim-57A143?logo=neovim&logoColor=white&style=flat-square)

---

## 🖥️ 系统技术栈与桌面环境

| 分类 | 核心组件 | 说明 |
| :--- | :--- | :--- |
| **操作系统** | **Arch Linux** | 滚动发行版 (Rolling Release) |
| **窗口管理器** | **Niri** | 新一代无限平铺/可滚动（Scrollable Tiling）Wayland 合成器 |
| **状态栏** | **Waybar** | 自定义动态状态栏、多功能小脚本、歌词与音频响应 |
| **动态主题** | **Matugen** | 基于 Material You 规范根据壁纸生成动态主题色调 |
| **壁纸管理** | **Waypaper** | 配合 swww / swaybg 的 GUI 壁纸切换器 |
| **终端模拟器** | **Kitty** / **Alacritty** | GPU 加速现代终端 |
| **命令行环境** | **Zsh** + **Starship** | 高颜值、快响应的 Prompt 与自动补全体系 |
| **文本编辑器** | **Neovim** (LazyVim) / **Vim** | 现代化 IDE 级别代码与配置编辑体验 |
| **通知系统** | **Mako** | 轻量级 Wayland 通知守护进程 |
| **输入法** | **Fcitx5** | Ayaya 主题与中英文无缝切换 |
| **截图与录屏** | **Satty** + **wl-screenrec** | 截图快速标注与屏幕录制套件 |
| **音频与音乐** | **MPD** + **ncmpcpp** + **Cava** | 音乐后台服务、TUI 客户端及桌面音频频谱可视化 |

---

## 📁 扁平化目录结构（1:1 镜像 `$HOME`）

本仓库采用最直观的 **`$HOME` 镜像布局**，配合 `.stow-local-ignore` 过滤非配置管理文件，彻底杜绝了传统 Stow 的套娃多层嵌套：

```text
dotfiles/
├── .config/                 # 1:1 镜像系统 ~/.config/
│   ├── alacritty/           # -> ~/.config/alacritty
│   ├── cava/                # -> ~/.config/cava
│   ├── fcitx5/              # -> ~/.config/fcitx5
│   ├── fontconfig/          # -> ~/.config/fontconfig
│   ├── gtk-3.0/             # -> ~/.config/gtk-3.0
│   ├── gtk-4.0/             # -> ~/.config/gtk-4.0
│   ├── kitty/               # -> ~/.config/kitty
│   ├── mako/                # -> ~/.config/mako
│   ├── matugen/             # -> ~/.config/matugen
│   ├── mpd/                 # -> ~/.config/mpd
│   ├── ncmpcpp/             # -> ~/.config/ncmpcpp
│   ├── niri/                # -> ~/.config/niri
│   ├── nvim/                # -> ~/.config/nvim
│   ├── satty/               # -> ~/.config/satty
│   ├── scripts/             # -> ~/.config/scripts (壁纸、模糊、主题切换脚本)
│   ├── starship.toml        # -> ~/.config/starship.toml
│   ├── swaylock/            # -> ~/.config/swaylock
│   ├── waybar/              # -> ~/.config/waybar
│   ├── waypaper/            # -> ~/.config/waypaper
│   └── xsettingsd/          # -> ~/.config/xsettingsd
│
├── .bash_logout             # -> ~/.bash_logout
├── .bash_profile            # -> ~/.bash_profile
├── .bashrc                  # -> ~/.bashrc
├── .gitconfig               # -> ~/.gitconfig
├── .gtkrc-2.0               # -> ~/.gtkrc-2.0
├── .vimrc                   # -> ~/.vimrc
├── .zshrc                   # -> ~/.zshrc
│
├── .stow-local-ignore       # 过滤 Git、说明文档与脚本，防止软链接到 $HOME
├── .gitignore
├── README.md
├── bootstrap.sh             # 一键部署与软链接同步脚本
└── packages/                # 软件包清单与自动化安装脚本
```

---

## 📦 软件包管理与备份（Package Management）

仓库内置了针对 **Arch Linux (pacman)**、**AUR (yay/paru)** 以及 **Flatpak** 的自动化备份与还原机制：

```text
packages/
├── export.sh            # 一键导出系统当前已安装的所有包列表
├── install.sh           # 一键从清单批量恢复/安装所有包
├── pacman-native.txt    # 官方仓库显式安装的软件包列表 (141个)
├── pacman-aur.txt       # AUR 显式安装的第三方/专有软件包列表 (23个)
└── flatpak.txt          # Flatpak 安装的沙盒应用程序列表 (3个)
```

### 1. 系统安装了新软件后（更新备份清单）
当你平时通过 `pacman`、`yay` 或 `flatpak` 安装了新工具后，只需运行：
```bash
./packages/export.sh
git add packages/
git commit -m "chore(pkg): update installed package lists"
git push
```

### 2. 新机器/系统重装后（批量还原安装所有软件）
```bash
./packages/install.sh
```

---

## 🚀 新机器从零快速还原指南

在新装的 Arch Linux 环境中，只需以下 3 步即可完整复现整套工作环境：

### 第一步：安装 Git 与 GNU Stow
```bash
sudo pacman -S --needed git stow
```

### 第二步：克隆本仓库到 `$HOME`
```bash
git clone https://github.com/bokeshiling/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 第三步：一键还原软件包并建立配置软链接
```bash
# 同时恢复软件包与配置文件链接
./bootstrap.sh --packages

# 或者只建立配置文件链接（跳过装包）
./bootstrap.sh
```

---

## 🔐 敏感信息与单机差异化隔离

为了防止个人 Token、公司内部路径、私有邮箱等意外提交到公共 GitHub 仓库，本仓库采用了 `.local` 解耦设计：

1. **Shell 配置 (Zsh/Bash)**：
   * 在 `~/.zshrc` 底部已预埋自动加载逻辑：`[ -f ~/.zshrc.local ] && source ~/.zshrc.local`
   * 任何专属单机的 PATH、环境变量、密钥别名直接写入 `~/.zshrc.local`。

2. **Git 个人身份**：
   * 在 `~/.gitconfig` 中配置了 `[include] path = ~/.gitconfig.local`
   * 可将个人 email 或 signingkey 写入未被跟踪的 `~/.gitconfig.local`。

> 💡 仓库的 `.gitignore` 已内置对 `*.local`、`*.secret`、`*.bak`、`*.log` 的自动忽略。

---

## 🛠️ Stow 维护命令速查

在新的扁平化架构下，所有操作只需一条指令：

| 操作 | 命令 | 说明 |
| :--- | :--- | :--- |
| **一键刷新全部软链接** | `stow -R -t ~ .` | 新增/修改文件后，一键重连所有配置 |
| **一键取消全部软链接** | `stow -D -t ~ .` | 安全移除所有软链接，仓库文件保持完好 |
| **模拟测试 (Dry-run)** | `stow -n -v -t ~ .` | 预演链接变动，不实际写入文件 |

---

## 📜 开源协议

本项目基于 [MIT License](LICENSE) 开源，欢迎自由定制与参考。
