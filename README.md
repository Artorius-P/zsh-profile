# zsh-profile
我的自用zsh配置（持续更新）

由于oh-my-zsh已不满足我的需求，因此自己抽空整理了配置文件

## 使用方法
安装starship和zsh-autosuggestions

```bash
brew install starship
brew install zsh-autosuggestions
```

创建了一个安装脚本，这个脚本具有以下特点：

备份功能：在安装前会自动备份你现有的zsh配置文件，带有时间戳，避免配置丢失。
保留现有配置：如果已经存在配置文件，脚本会采用追加而非覆盖的方式，在文件末尾添加新配置。
创建符号链接：为了便于后续更新，脚本会在 ~/.zsh_custom 目录下创建指向原始配置文件的符号链接。
默认shell检测：检查并询问是否需要将默认shell切换为zsh。

使用方法：

给脚本添加执行权限：

```bash
chmod +x install.sh
```

执行脚本：

```bash
./install.sh
```

脚本会交互式地询问你是否继续安装，并在过程中提供清晰的状态信息。所有备份文件都会保存在` ~/.zsh_config_backup` 目录中，以便你需要时可以恢复。
