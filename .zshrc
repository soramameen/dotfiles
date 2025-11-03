# 最初に追加
# OS判定
if [[ "$OSTYPE" == "darwin"* ]]; then
    # ==================== Mac ====================
    eval "$(/opt/homebrew/bin/brew shellenv)"
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # ==================== Linux (Ubuntu) ====================
    # zoxideのパスを追加
    export PATH="$HOME/.local/bin:$PATH"
fi

# ... 以下共通設定 ...
# ==================== 開発環境 ====================
# Ruby (rbenv)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Node.js (pnpm)
export PNPM_HOME="/Users/nakajimasoraera/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# PostgreSQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# ==================== Python (Conda) ====================
# >>> conda initialize >>>
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
# <<< conda initialize <

# ==================== エディタ ====================
export EDITOR=nvim

# ==================== プロジェクト専用関数 ====================
sakumiru_apps_pr() {
  (cd /Users/nakajimasoraera/pro/sakumiru/sakumiru-apps/scripts && pnpm pr)
}

sakumiru_admin_pr() {
  (cd /Users/nakajimasoraera/pro/sakumiru/sakumiru-admin/scripts && pnpm pr)
}

# ==================== Git エイリアス ====================
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gc-dev='git checkout develop'

# ==================== Docker エイリアス ====================
alias dce='docker compose exec'
alias rubo='docker compose exec api rubocop -A'
alias ridge='docker compose exec api rails ridgepole:apply\[false\]'

# ==================== 開発エイリアス ====================
alias update='pnpm get-schema && pnpm codegen'

# ==================== ツールエイリアス ====================
alias n='nvim'
alias lgit='lazygit'
alias ldocker='lazydocker'
alias cat='bat -pP'
alias l="eza --group-directories-first -1 -l -F -a -b --icons"
alias files='yazi'
alias catmd='glow'
# ==================== ディレクトリ ====================
alias obsidian='cd /Users/nakajimasoraera/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/mydream'
alias today='nvim "/Users/nakajimasoraera/Library/Mobile Documents/iCloud~md~obsidian/Documents/mydream/毎日振り返り/$(date +%Y-%m-%d).md"'

# ==================== ツール初期化 ====================
# zoxide (スマートcd)
eval "$(zoxide init zsh)"

# Starship (プロンプト)
eval "$(starship init zsh)"

# Docker補完
fpath=(/Users/nakajimasoraera/.docker/completions $fpath)
autoload -Uz compinit
compinit

# ローカル専用設定を読み込み（存在すれば）
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Complement

# Thanks: https://thevaluable.dev/zsh-completion-guide-examples/
zstyle ':completion:*' completer _extensions _complete _approximate
# add colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# selectable menu
zstyle ':completion:*:default' menu 'select'
# match both lower and upper
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
# sort by modification time
zstyle ':completion:*' file-sort 'modification'

# for fzf-tab

# Thanks: https://github.com/Aloxaf/fzf-tab/issues/58
zstyle ':completion:complete:*:argument-rest' sort false
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' accept-line enter

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"


source <(fzf --zsh)

eval "$(sheldon source)"
