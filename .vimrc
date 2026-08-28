" ================= 插件管理 (vim-plug) =================
call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'          " onedark 主题
Plug 'vim-airline/vim-airline'       " 状态栏
Plug 'vim-airline/vim-airline-themes' " 状态栏主题

call plug#end()

" ================= Vim 基础设置 =================
syntax on             " 开启语法高亮
set number            " 显示行号
set relativenumber    " 显示相对行号
set cursorline        " 高亮当前光标行
set mouse=a           " 鼠标支持
set tabstop=4         " Tab = 4 空格
set shiftwidth=4      " 缩进 = 4 空格
set expandtab         " 用空格代替 Tab
set autoindent        " 自动缩进
set smartindent       " 智能缩进
set termguicolors     " 真彩色

" ================= 搜索设置 =================
set incsearch         " 输入时实时搜索
set hlsearch          " 高亮搜索结果
set ignorecase        " 搜索忽略大小写
set smartcase         " 有大写字母时区分大小写
noremap <Esc> <Esc>:nohlsearch<CR> " Esc 清除搜索高亮

" ================= 编辑体验 =================
set clipboard=unnamedplus " 与系统剪贴板互通
set scrolloff=8       " 光标上下留 8 行余量
set hidden            " 切换 buffer 不用先保存
set undofile          " 持久化撤销历史
set undodir=~/.vim/undo " 撤销历史存放目录
set signcolumn=auto   " 自动显示侧边符号列

" ================= 主题与状态栏 =================
colorscheme onedark   " onedark 主题
let g:airline_theme='onedark' " airline 跟随 onedark
let g:airline_powerline_fonts=1 " 启用状态栏特殊字符（需 powerline 字体）
