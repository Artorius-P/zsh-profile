# pnpm
export PNPM_HOME="/Users/artorius/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# === 由安装脚本添加于 Mon Mar 24 08:43:01 CST 2025 ===

# .zshrc - 基本轻量级配置

# 历史记录设置
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # 在多个 zsh 会话间共享历史记录
setopt HIST_IGNORE_ALL_DUPS   # 忽略重复的命令
setopt HIST_SAVE_NO_DUPS      # 不保存重复的命令
setopt HIST_REDUCE_BLANKS     # 删除历史记录中多余的空格

# 基本设置
setopt AUTO_CD               # 输入目录名可直接进入该目录
setopt CORRECT               # 命令拼写检查
setopt INTERACTIVE_COMMENTS  # 允许交互模式中的注释

# 补全系统设置
autoload -Uz compinit && compinit

zstyle ':completion:*' menu select                # 菜单式补全
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # 忽略大小写
zstyle ':completion:*' rehash true               # 自动更新PATH中的命令
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # 使用 LS_COLORS 给补全结果上色
zstyle ':completion:*' verbose yes               # 提供详细的补全信息

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/artorius/.docker/completions $fpath)

# 目录栈功能
setopt AUTO_PUSHD           # 自动将目录加入目录栈
setopt PUSHD_IGNORE_DUPS    # 忽略重复的目录
setopt PUSHD_SILENT         # pushd 和 popd 不打印目录栈

# 加载 zsh-autosuggestions 插件
if [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # 自定义 zsh-autosuggestions 设置
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)  # 使用历史记录和补全作为建议来源
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20             # 限制缓冲区大小以提高性能
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8f8f8f"   # 建议文本的颜色
fi

# 加载 starship 提示符
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# 加载自定义函数
if [ -f ~/.zsh_functions ]; then
    source ~/.zsh_functions
fi

# 加载别名
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# 在工作环境中常用的功能
export EDITOR='nvim'  # 设置默认编辑器

# PATH 设置
# 添加自定义路径到 PATH (根据需要修改)
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
source $HOME/bin/zsh_script.sh
