## 环境配置

### neovim

#### Windows
可以使用`Scoop`或`Chocolatey`

#### 源码编译

```
git clone https://github.com/neovim/neovim.git
git checkout v0.11.1
make CMAKE_BUILD_TYPE=Release
sudo make install
```

默认安装到/usr/local，可以自定义安装目录

```
rm -r build/  # clear the CMake cache
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install
export PATH="$HOME/neovim/bin:$PATH"
```

卸载

```
sudo cmake --build build/ --target uninstall
```

或者手动删除CMAKE_INSTALL_PREFIX

```
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
```

### LazyVim
```
sudo apt install luarocks ripgrep fd-find fzf
```

### Copilot-Chat
`node.js`：推荐使用nvm安装
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```
