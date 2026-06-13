#!/usr/bin/env zsh

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/completion.zsh
source <(fzf --zsh)

eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
