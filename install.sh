#!/bin/bash

# 设置颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 打印带颜色的信息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否已安装zsh
if ! command -v zsh &> /dev/null; then
    print_error "zsh未安装，请先安装zsh后再运行此脚本"
    exit 1
fi

# 定义目标目录
ZSH_CONFIG_DIR="$HOME/.zsh_config_backup"
CURRENT_DIR=$(pwd)

# 创建备份目录
backup_configs() {
    print_info "备份现有的zsh配置文件..."
    
    # 确保备份目录存在
    mkdir -p "$ZSH_CONFIG_DIR"
    
    # 获取当前时间作为备份标识
    BACKUP_TIME=$(date +"%Y%m%d_%H%M%S")
    
    # 备份现有配置
    for file in ~/.zshrc ~/.zprofile ~/.aliases ~/.zsh_functions; do
        if [ -f "$file" ]; then
            cp "$file" "$ZSH_CONFIG_DIR/$(basename $file)_backup_$BACKUP_TIME"
            print_info "已备份 $(basename $file) 到 $ZSH_CONFIG_DIR/$(basename $file)_backup_$BACKUP_TIME"
        fi
    done
    
    print_success "备份完成"
}

# 安装配置文件
install_configs() {
    print_info "开始安装zsh配置文件..."
    
    # 复制配置文件，保持原有的其他配置
    for file in "aliases" "zprofile" "zsh_functions" "zshrc"; do
        if [ -f "$CURRENT_DIR/$file" ]; then
            # 检查目标文件是否存在
            TARGET_FILE="$HOME/.${file}"
            
            if [ -f "$TARGET_FILE" ]; then
                # 如果已存在，追加内容而不是覆盖
                print_info "发现已存在的 $TARGET_FILE，将追加新配置..."
                
                # 添加分隔符
                echo -e "\n# === 由安装脚本添加于 $(date) ===\n" >> "$TARGET_FILE"
                
                # 追加配置内容
                cat "$CURRENT_DIR/$file" >> "$TARGET_FILE"
            else
                # 如果不存在，直接复制
                cp "$CURRENT_DIR/$file" "$TARGET_FILE"
            fi
            
            print_success "配置 $file 已安装至 $TARGET_FILE"
        else
            print_error "找不到源文件 $CURRENT_DIR/$file"
        fi
    done
}

# 检测是否需要切换默认shell
check_default_shell() {
    if [[ "$SHELL" != *"zsh"* ]]; then
        print_info "当前默认shell不是zsh，是否切换默认shell为zsh? [Y/n]"
        read -r response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY]|)$ ]]; then
            chsh -s $(which zsh)
            print_success "默认shell已切换为zsh，重新登录后生效"
        else
            print_info "保持当前默认shell不变，你可以随时使用 'zsh' 命令启动zsh"
        fi
    else
        print_info "当前默认shell已经是zsh"
    fi
}

# 添加自定义功能
setup_custom_features() {
    print_info "设置自定义特性..."
    
    # 创建源文件链接而不是复制
    mkdir -p "$HOME/.zsh_custom"
    
    # 可选：创建源文件的符号链接
    ln -sf "$CURRENT_DIR/zsh_functions" "$HOME/.zsh_custom/functions"
    ln -sf "$CURRENT_DIR/aliases" "$HOME/.zsh_custom/aliases"
    
    print_info "已在 ~/.zsh_custom 下创建配置文件的符号链接，便于后续更新"
}

# 主函数
main() {
    print_info "ZSH配置安装脚本开始执行..."
    
    # 询问用户是否继续
    print_info "此脚本将安装zsh配置文件，并备份现有配置。是否继续? [Y/n]"
    read -r response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY]|)$ ]]; then
        print_info "已取消安装"
        exit 0
    fi
    
    # 执行安装步骤
    backup_configs
    install_configs
    setup_custom_features
    check_default_shell
    
    print_success "ZSH配置安装完成!"
    print_success "你可以通过运行 'source ~/.zshrc' 来立即应用新配置，或者重新打开终端"
    print_info "备份的配置文件保存在: $ZSH_CONFIG_DIR"
}

# 执行主函数
main
