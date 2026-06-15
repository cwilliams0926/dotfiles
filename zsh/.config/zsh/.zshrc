#!/usr/bin/env zsh

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/completion.zsh
source <(fzf --zsh)

eval "$(starship init zsh)"
source ~/.config/zsh/plugins/fzf-tab/fzf-tab.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
