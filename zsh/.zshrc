eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

source <(fzf --zsh)

alias psmouse="sudo modprobe -r psmouse && sudo modprobe psmouse"

# Created by `pipx` on 2026-05-27 02:57:32
export PATH="$PATH:/home/cwilliams0926/.local/bin"
