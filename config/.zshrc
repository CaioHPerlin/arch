# binds
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# aliases
alias ls='ls --color=auto'

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINsIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# zinit plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# oh my posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/omp.json)"
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/omp.toml)"

# fzf
source <(fzf --zsh --style full --preview 'cat {}' --preview-window right:60%:wrap)

# nvm
export NVM_HOME="$HOME/.nvm"
[ -s "$NVM_HOME/nvm.sh" ] && . "$NVM_HOME/nvm.sh"

# bin
export PATH="$HOME/.local/bin:$PATH"
