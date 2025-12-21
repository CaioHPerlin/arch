# binds
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# aliases
alias ls='ls --color=auto'
alias s='kitten ssh'
alias d2m-vpn-cerdil='sudo openfortivpn -c /etc/openfortivpn/tazy'

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


# pnpm
export PNPM_HOME="/home/perlin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
