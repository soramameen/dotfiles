eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home
export NFC_HOME=~/opt/nfc-0.1a_25E196
export PATH=$JAVA_HOME/bin:$NFC_HOME/bin:$PATH
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export NFC_HOME=/Users/nakajimasoraera/opt/nfc-0.1a_25E196
export PATH=$JAVA_HOME/bin:$NFC_HOME/bin:$PATH
export PATH="/usr/local/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
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
# <<< conda initialize <<<

export PATH=/usr/local/smlnj/bin:"$PATH"
export NODE_AUTH_TOKEN=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
export GITHUB_TOKEN=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

export EDITOR="cursor --wait"

sakumiru_apps_pr() {
  (cd /Users/nakajimasoraera/pro/sakumiru/sakumiru-apps/scripts && pnpm pr)
}
sakumiru_admin_pr() {
  (cd /Users/nakajimasoraera/pro/sakumiru/sakumiru-admin/scripts && pnpm pr)
}

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# alias

alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
alias gc-dev='git checkout develop'

alias rubo='docker compose exec api rubocop -A'

alias dce='docker compose exec'
alias update='pnpm get-schema && pnpm codegen'
alias ridge='docker compose exec api rails ridgepole:apply\[false\]'

alias obsidian='cd /Users/nakajimasoraera/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/mydream'
alias files='yazi'
# lazy
alias lgit='lazygit'
alias ldocker='lazydocker'

# pnpm
export PNPM_HOME="/Users/nakajimasoraera/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/nakajimasoraera/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
export EDITOR=nvim

# ゼロからのOS自作入門
export PATH="/opt/homebrew/opt/llvm@14/bin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"

eval "$(zoxide init zsh)"
alias "l"="eza --group-directories-first -1 -l -F -a -b --icons"
eval "$(starship init zsh)"
alias cat='bat -pP'




