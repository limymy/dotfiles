-- Windows Neovim entrypoint.
-- This file lives at %LOCALAPPDATA%\nvim\init.lua by default.
-- It forwards to ~/.config/nvim so we can share the same config with Linux/WSL
-- without requiring PowerShell profile env var tweaks.

local uv = vim.uv or vim.loop
local home = vim.fs.normalize(uv.os_homedir())

local xdg_config_home = home .. "/.config"
local nvim_config_dir = xdg_config_home .. "/nvim"

vim.env.XDG_CONFIG_HOME = xdg_config_home
vim.opt.runtimepath:prepend(nvim_config_dir)

dofile(nvim_config_dir .. "/init.lua")
