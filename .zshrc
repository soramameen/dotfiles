# ==================== OS判定 & 初期設定 ====================
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (Ubuntu)
    export PATH="$HOME/.local/bin:$PATH"
fi

# ==================== パス & 言語設定 ====================
# Ruby (rbenv)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Node.js (pnpm)
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Java
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# PostgreSQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Build tools (Compiler path etc)
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LIBRARY_PATH="/opt/homebrew/opt/flex/lib:$LIBRARY_PATH"
export CPATH="/opt/homebrew/opt/flex/include:$CPATH"

# Python (Conda)
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup

# ==================== エディタ設定 ====================
export EDITOR=nvim

# ==================== プロジェクト関数 ====================
sakumiru_apps_pr() {
  (cd "$HOME/pro/sakumiru/sakumiru-apps/scripts" && pnpm pr)
}

sakumiru_admin_pr() {
  (cd "$HOME/pro/sakumiru/sakumiru-admin/scripts" && pnpm pr)
}

# ==================== エイリアス ====================
# Git
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gc-dev='git checkout develop'
alias lg='lazygit'

# Docker
alias ld='lazydocker'
alias dce='docker compose exec'
alias rubo='docker compose exec api rubocop -A'
alias ridge='docker compose exec api rails ridgepole:apply\[false\]'

# NeoVim
alias n='nvim'
alias oldnvim="NVIM_APPNAME=oldnvim nvim"

# Tools
alias update='pnpm get-schema && pnpm codegen'
alias l="eza --group-directories-first -1 -l -F -a -b --icons"
alias files='yazi'
alias man='tldr'
alias t='tmux'

# Web Search
alias web='open -a "Zen"'
alias search='web "https://www.google.com/search?q=$1"'

# Shortcuts
alias obsidian='cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/mydream"'
alias today='nvim "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/mydream/毎日振り返り/$(date +%Y-%m-%d).md"'

# ==================== カスタム関数 ====================
# smart cat (scat)
scat() {
  local file="$1"
  local max_size=$((10 * 1024 * 1024))  # 10MB
  local size

  # OSごとのファイルサイズ取得
  if [[ "$OSTYPE" == "darwin"* ]]; then
      size=$(stat -f%z "$file" 2>/dev/null) # Mac
  else
      size=$(stat -c%s "$file" 2>/dev/null) # Linux
  fi

  # ファイルが存在しない、または大きすぎる場合は通常のcat
  if [[ -z $size ]] || [[ $size -gt $max_size ]]; then
    command cat "$file"
    return
  fi

  case "$file" in
    *.md) glow "$file" ;;
    *) bat -pP "$file" ;;
  esac
}

# ==================== ツール初期化 ====================
# zoxide
eval "$(zoxide init zsh)"
# Starship
eval "$(starship init zsh)"
# Sheldon (Plugin Manager)
eval "$(sheldon source)"

# ==================== 補完(Completion)設定 ====================
# Docker補完パス追加
fpath=("$HOME/.docker/completions" $fpath)

# 補完システムの初期化 (ここは1回だけでOK)
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# 補完スタイル設定
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' menu 'select'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' file-sort 'modification'

# fzf-tab用設定 (補完時の挙動)
zstyle ':completion:complete:*:argument-rest' sort false
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' accept-line enter

# ==================== fzf設定 & プレビュー修正 ====================
source <(fzf --zsh)

# fzfの見た目
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# Ctrl+t などでのプレビュー設定
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {} || cat {}'"

# -----------------------------------------------------------
# 【重要】ここが修正ポイント：fzf-tabのプレビューエラー回避設定
# -----------------------------------------------------------

# 1. cdコマンドの補完時は eza でディレクトリの中身を表示
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# 2. kill/psコマンドの補完時は ps コマンドでプロセス詳細を表示 (catを使わせない)
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# 3. それ以外のファイル補完は bat を使う
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath'

# ==================== ローカル設定読み込み ====================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ==================== 起動時ロゴ (Tmux外のみ) ====================
if [[ -z "$TMUX" ]]; then
  clear
  fastfetch
fi

export MAPS_HOME="$HOME/opt/maps-1.5"
PATH=$PATH:$MAPS_HOME/bin
export PATH
