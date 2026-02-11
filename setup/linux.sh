#!/bin/bash

# ~/dotfiles/setup/linux.sh

echo "🐧 Setting up Linux (Ubuntu)..."

confirm() {
  local prompt="$1"
  if [ "${DOTFILES_ASSUME_YES}" = "1" ]; then
    return 0
  fi
  read -r -p "$prompt [y/N]: " reply
  case "$reply" in
    [yY]|[yY][eE][sS]) return 0 ;;
    *) return 1 ;;
  esac
}

# システムアップデート
if confirm "Update system packages (apt update/upgrade)?"; then
  echo "📦 Updating system..."
  sudo apt update && sudo apt upgrade -y
else
  echo "⏭️  Skipping system update."
fi

# 基本ツール
if confirm "Install basic tools (apt)?"; then
  echo "📦 Installing basic tools..."
  sudo apt install -y \
    git \
    curl \
    wget \
    zsh \
    tmux \
    build-essential \
    fzf \
    ripgrep \
    unzip \
    xclip
else
  echo "⏭️  Skipping basic tools install."
fi

# bat (batcat という名前)
if confirm "Install bat (batcat) and create symlink?"; then
  sudo apt install -y bat
  mkdir -p ~/.local/bin
  ln -sf /usr/bin/batcat ~/.local/bin/bat
else
  echo "⏭️  Skipping bat install."
fi

# Neovim (AppImage - 最新版)
if confirm "Install Neovim (AppImage)?"; then
  echo "📦 Installing Neovim..."
  if ! command -v nvim &>/dev/null; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
    echo "✅ Neovim installed"
  else
    echo "✅ Neovim already installed"
  fi
else
  echo "⏭️  Skipping Neovim install."
fi

# eza (modern ls)
if confirm "Install eza (adds apt repo)?"; then
  echo "📦 Installing eza..."
  if ! command -v eza &>/dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
    echo "✅ eza installed"
  else
    echo "✅ eza already installed"
  fi
else
  echo "⏭️  Skipping eza install."
fi

# zoxide (smart cd)
if confirm "Install zoxide?"; then
  echo "📦 Installing zoxide..."
  if ! command -v zoxide &>/dev/null; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    echo "✅ zoxide installed"
  else
    echo "✅ zoxide already installed"
  fi
else
  echo "⏭️  Skipping zoxide install."
fi

# Starship (prompt)
if confirm "Install Starship prompt?"; then
  echo "📦 Installing Starship..."
  if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin -y
    echo "✅ Starship installed"
  else
    echo "✅ Starship already installed"
  fi
else
  echo "⏭️  Skipping Starship install."
fi

# lazygit
if confirm "Install lazygit?"; then
  echo "📦 Installing lazygit..."
  if ! command -v lazygit &>/dev/null; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
    echo "✅ lazygit installed"
  else
    echo "✅ lazygit already installed"
  fi
else
  echo "⏭️  Skipping lazygit install."
fi

# Nerd Font
if confirm "Install JetBrains Mono Nerd Font?"; then
  echo "📦 Installing JetBrains Mono Nerd Font..."
  FONT_DIR="$HOME/.local/share/fonts"
  if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    mkdir -p "$FONT_DIR"
    cd "$FONT_DIR"
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    unzip -q JetBrainsMono.zip
    rm JetBrainsMono.zip
    fc-cache -fv >/dev/null 2>&1
    cd - >/dev/null
    echo "✅ Font installed"
  else
    echo "✅ Font already installed"
  fi
else
  echo "⏭️  Skipping font install."
fi

# Alacritty (optional)
#echo "📦 Installing Alacritty..."
#if ! command -v alacritty &> /dev/null; then
#    sudo add-apt-repository ppa:aslatter/ppa -y
#    sudo apt update
#    sudo apt install -y alacritty
#    echo "✅ Alacritty installed"
#else
#    echo "✅ Alacritty already installed"
#fi

echo "✅ Linux setup complete!"
