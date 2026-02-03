dotfiles（Linux / Windows / WSL），使用 **chezmoi** 管理。

核心目标：
- 跨平台统一配置（尤其是 Neovim）
- profiles：`dev`（开发机）与 `basic`（服务器/非开发环境）
- `basic` 仍支持 YAML/JSON/TOML 的 **schema 校验** + **自动格式化**（需要 Node 运行时）
- 不在仓库中管理 SSH 私钥

## 使用（首次）

### 1) 安装 chezmoi

**Linux/WSL（官方安装脚本）**
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
```

**Windows（Scoop）**
```powershell
scoop install chezmoi
```

安装后确认：
```bash
chezmoi --version
```

### 2) 应用仓库配置（初始化 + apply）

**推荐：从远端仓库初始化**（会克隆到 `~/.local/share/chezmoi`）
```bash
chezmoi init --apply <repo-url>
```

首次会提示选择 profile：
- `dev`: 开发机
- `basic`: 服务器/非开发环境

profile 会写入 `~/.config/chezmoi/chezmoi.toml`（本机文件，不进 git）。也可以手动改：
```toml
[data]
profile = "basic" # or "dev"
```
改完执行：
```bash
chezmoi apply
```

**本地测试**（直接用当前工作区作为 sourceDir，适合测试未提交改动）
```bash
cd /path/to/dotfiles
chezmoi -S "$PWD" apply --init
```

### 3) 更新配置（把仓库最新变更拉到本机并应用）

```bash
chezmoi update
```

如果提示 `config file template has changed`：
```bash
chezmoi update --init
```

## 维护仓库（把本机改动同步回仓库）

### 编辑配置（推荐）
```bash
chezmoi edit --apply ~/.config/nvim/lua/config/keymaps.lua
```

### 把“目标目录里被工具改动”的文件收回仓库

例如在 Neovim 里 `:Lazy sync` / `:Lazy update` 后会更新锁文件：
```bash
chezmoi add ~/.config/nvim/lazy-lock.json
```

新增/修改插件 spec 后（`lua/plugins/*.lua`）：
```bash
chezmoi add ~/.config/nvim/lua/plugins
```

然后再用 git 提交/推送。

## 取消配置应用 / 停止管理

### 移除某部分配置并停止管理（会删除目标文件）
```bash
chezmoi destroy ~/.config/nvim
chezmoi destroy ~/.zshrc ~/.tmux.conf
```

### 仅卸载 chezmoi（保留当前已经应用到 $HOME 的文件）
```bash
chezmoi purge
```

## Neovim

- Linux/WSL：配置落在 `~/.config/nvim`
- Windows：使用 `%LOCALAPPDATA%\nvim\init.lua` 作为入口，转发到 `~/.config/nvim`（无需改 PowerShell profile）

### 删除行为（允许清理遗留文件）

默认情况下：**从仓库（source state）删除某个文件，只是“停止管理”，不会自动删除本机 `$HOME` 里的同名文件**。

本仓库对 Neovim 配置目录启用了 chezmoi 的 `exact_` 目录属性，使其与仓库保持一致：
- `~/.config/nvim`
- `~/.config/nvim/lua`
- `~/.config/nvim/lua/config`
- `~/.config/nvim/lua/plugins`

因此：这些目录里任何“不在仓库中的文件/目录”（例如你在仓库里删掉了某个 lua 文件导致本机变成遗留文件），都会在 `chezmoi apply` 时被删除。

常用命令：
```bash
# 预览将会删除/变更的内容
chezmoi apply -n -v --no-pager

# 查看 ~/.config/nvim 下有哪些未管理（会被 exact_ 清理）的文件
chezmoi unmanaged ~/.config/nvim --path-style relative --no-pager

# 真正应用（包含删除）
chezmoi apply -v --no-pager
```

如果你是用本地工作区测试（`chezmoi -S "$PWD"`），则在以上命令前加 `-S "$PWD"`。

### basic profile（服务器/非开发）

- Neovim 仍使用 LazyVim，但只启用配置文件编辑所需的 extras/LSP：`yamlls` / `jsonls` / `taplo`
- 保存自动格式化：yaml/yml/json/toml
- schema：YAML/JSON 使用 SchemaStore

要求：服务器需要可用的 Node（仅运行时）。

## 目录结构（chezmoi source state）

本仓库的 source state 在 `./home`（见 `.chezmoiroot`）。
- `home/dot_config/...` → `~/.config/...`
- `home/dot_config/exact_nvim/...` → `~/.config/nvim`（启用 `exact_`，会清理未管理文件）
- `home/dot_zshrc` → `~/.zshrc`（Windows 上会被忽略）
- `home/dot_tmux.conf` → `~/.tmux.conf`（Windows 上会被忽略）

## Docs

- [Neovim](docs/nvim.md)
- [zsh](docs/zsh.md)
- [tmux](docs/tmux.md)
