-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- define common options
local opts = {
  noremap = true,      -- non-recursive
  silent = true,       -- do not show message
}

-----------------
-- Insert mode --
-----------------
vim.keymap.set('i', 'jj', '<Esc>', opts)

-----------------
--Terminal mode--
-----------------
-- 退出终端插入模式
vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)
-- 在终端里直接用 <C-hjkl> 切窗口
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

