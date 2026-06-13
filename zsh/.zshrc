eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

source <(fzf --zsh)

# Created by `pipx` on 2026-05-27 02:57:32
export PATH="$PATH:/home/cwilliams0926/.local/bin"

export PATH=~/.npm-global/bin:$PATH

alias psmouse="sudo modprobe -r psmouse && sudo modprobe psmouse"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
