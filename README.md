可以使用`GNU stow`管理的dotfiles，包含`nvim`，`tmux`，`zsh`

## 安装依赖

### GNU stow
```
sudo apt install stow
```
各个工具的配置需求请进入子文件夹查看

## 使用方法

```
stow nvim tmux zsh
```

或者单独应用某项配置，例如`nvim`

```
stow nvim
```


## 其它

windows系统中无法使用`stow`工具，仓库中包含脚本工具，可以通过运行
```
.\nvim\win-link.ps1
```
为`nvim`配置项创建软链接
