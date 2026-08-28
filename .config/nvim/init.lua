require('options')        -- 基础配置
require('lazyinit')       -- 插件配置 (lazy.nvim)
require('keymap')         -- 按键配置
require('lspinit')        -- LSP 配置

-- 本机私有/个性化配置 (可创建 ~/.config/nvim/lua/local.lua，已被 .gitignore 忽略)
pcall(require, 'local')
