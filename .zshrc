# ==================== OS判定 & 初期設定 ====================
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (Ubuntu)
    # export PATH="$HOME/.local/bin:$PATH"  <-- ここにあったのを削除
fi

# ==================== パス & 言語設定 ====================
# ユーザーローカルbin (OS問わず共通で使う)
export PATH="$HOME/.local/bin:$PATH"

## Ruby (rbenv)
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
# miseに移行するためコメントアウト

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

export PATH="$HOME/.opencode/bin:$PATH"

# ==================== エディタ設定 ====================
export EDITOR=nvim

# ==================== エイリアス ====================
# Git
alias lg='lazygit'

# Docker
alias ld='lazydocker'
alias dce='docker compose exec'
alias rubo='docker compose exec api rubocop -A'
alias ridge='docker compose exec api rails ridgepole:apply\[false\]'

# NeoVim
alias n='nvim'

# Tools
alias l="eza --group-directories-first -1 -l -F -a -b --icons"
alias files='yazi'
alias t='tmux'
alias oc='opencode'

#tmux
alias tl="tmux ls"
alias ta="tmux a"
alias tkt="tmux kill-session -t"
alias tk="tmux kill-session"

# Web Search
alias web='open -a "Zen"'
alias search='web "https://www.google.com/search?q=$1"'

# ==================== Auto Notify Config ====================
export AUTO_NOTIFY_THRESHOLD=10
export AUTO_NOTIFY_TITLE="Task Completed"
export AUTO_NOTIFY_BODY="Command: %command\nTime: %elapsed s"
# Ignore list
export AUTO_NOTIFY_IGNORE=(
    'tmux' 'nvim' 'vim' 'man' 'less' 'more' 'top' 'htop' 'ssh'
    'git commit' 'nano' 'watch'
)

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

export PATH="$HOME/bin:$PATH"
eval "$(mise activate zsh)"
alias dev="~/tmux-dev.sh"
