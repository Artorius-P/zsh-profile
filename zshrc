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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 忽略大小写
zstyle ':completion:*' rehash true               # 自动更新PATH中的命令
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # 使用 LS_COLORS 给补全结果上色
zstyle ':completion:*' verbose yes               # 提供详细的补全信息

# 目录栈功能
setopt AUTO_PUSHD           # 自动将目录加入目录栈
setopt PUSHD_IGNORE_DUPS    # 忽略重复的目录
setopt PUSHD_SILENT         # pushd 和 popd 不打印目录栈

# 加载 zsh-autosuggestions 插件
if [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # 自定义 zsh-autosuggestions 设置
  zstyle ':autocomplete:*' min-input 1           # 只需输入一个字符就开始自动补全
  zstyle ':autocomplete:*' insert-unambiguous no  # 不自动插入无歧义前缀
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
export PATH="$HOME/.local/bin:$PATH"
