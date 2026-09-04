#!/usr/bin/env zsh

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/completion.zsh
source <(fzf --zsh)
source ~/.config/zsh/plugins/fzf-tab/fzf-tab.zsh

eval "$(starship init zsh)"
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(autosuggest-accept)
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^Y' autosuggest-accept
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Lazy loading nvm
export NVM_DIR="$HOME/.config/nvm"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    nvm "$@"
}
node() { nvm; node "$@"; }
npm()  { nvm; npm  "$@"; }
npx()  { nvm; npx  "$@"; }
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[[ ! -f /tmp/nitch_shown ]] && touch /tmp/nitch_shown && nitch
